//
//  LocationInfoViewController.swift
//  Around Me - Meetup Events Nearby
//
//  Created by Evan Lewis on 4/8/16.
//  Copyright © 2016 Evan Lewis. All rights reserved.
//

import UIKit
import CoreLocation

class LocationInfoViewController: UIViewController, UITextFieldDelegate {
  
  @IBOutlet weak var useLocationButton: UIButton!
  @IBOutlet weak var zipCodeTextField: UITextField!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  
  var locationManager = CLLocationManager()
  var events = [Event]()
  
  // The didUpdateLocations function will update multiple times in order to get the correct location. The first few are usually from a previous location
  var refreshCounter = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    locationManager.delegate = self
    zipCodeTextField.delegate = self

  }
  
  override func viewDidAppear(animated: Bool) {
    LocationManager.sharedInstance.didUpdateLocation = false
  }
  
  // MARK: Actions
  @IBAction func useLocationButtonPressed(sender: UIButton) {
    sender.selected = true
    
    if CLLocationManager.authorizationStatus() == .NotDetermined {
      locationManager.requestWhenInUseAuthorization()
    } else if CLLocationManager.authorizationStatus() == .Denied {
      sender.selected = false
    
      // Displays an alert that the user has not allowed location access
      let alertController = UIAlertController(title: "Location Services is disabled", message: "For this feature, AroundMe needs access to your location. Please turn on Location Servies in your device settings.", preferredStyle: .Alert)
      let alertAction = UIAlertAction(title: "Ok", style: .Default, handler: nil)
      alertController.addAction(alertAction)
      self.presentViewController(alertController, animated: true, completion: nil)
      
    }
    
    // If the Location manager has an updated location, go to the table view
    if LocationManager.sharedInstance.didUpdateLocation == true {
      useLocationButton.selected = false
      self.performSegueWithIdentifier("toEventsTableView", sender: self)
    }
  }
  
  @IBAction func cancelKeyboardButtonPressed(sender: UIButton) {
    self.view.endEditing(true)
  }
  
  override func viewWillDisappear(animated: Bool) {
    activityIndicator.stopAnimating()
  }
  
  // MARK: Text Field Delegate
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    if let zip = textField.text {
      LocationManager.sharedInstance.setZipCode(zip)
      self.performSegueWithIdentifier("toEventsTableView", sender: self)
    }
    self.view.endEditing(true)
    return false
  }
  
}

// MARK: LocationManagerDelegate
extension LocationInfoViewController: CLLocationManagerDelegate {
  
  func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let lastKnownLocation = locations.last where LocationManager.sharedInstance.didUpdateLocation == false else { return }
      // Make sure the location is correct
      refreshCounter += 1
      useLocationButton.alpha = 0.5
      activityIndicator.startAnimating()
    
      // Once we have an accurate location, set it in the location manager
      if refreshCounter >= 3 {
        LocationManager.sharedInstance.setLatAndLong(lastKnownLocation)
        LocationManager.sharedInstance.didUpdateLocation = true
        refreshCounter == 0
        activityIndicator.stopAnimating()
        useLocationButton.alpha = 1.0
        // If the user had tapped on the location button, segue
        if useLocationButton.selected == true {
          useLocationButton.selected = false
          self.performSegueWithIdentifier("toEventsTableView", sender: self)
        }
      }
  }
  
  func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
    if status == .AuthorizedWhenInUse {
      manager.startUpdatingLocation()
    }
  }
}
