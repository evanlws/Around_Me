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
    }
    
    if LocationManager.sharedInstance.didUpdateLocation == true {
      useLocationButton.selected = false
      DownloadManager.sharedInstance.downloadEvents(forCategory: EventCategories.Technology, completion: { (events, error) in
        self.didFetchEvents(events)
      })
    }
  }
  
  @IBAction func cancelKeyboardButtonPressed(sender: UIButton) {
    self.view.endEditing(true)
  }
  
  // MARK: Text Field Delegate
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    if let zip = textField.text {
      LocationManager.sharedInstance.setZipCode(zip)
      DownloadManager.sharedInstance.downloadEvents(forCategory: EventCategories.Technology, completion: { (events, error) in
        self.didFetchEvents(events)
      })
    }
    self.view.endEditing(true)
    return false
  }
  
  // MARK: Navigation

  func didFetchEvents(events: [Event]) {
    print("Did receive \(events.count) events")
    self.events = events
    self.performSegueWithIdentifier("toEventsTableView", sender: self)
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    guard let eventsTableVC = segue.destinationViewController as? EventsTableViewController where segue.identifier == "toEventsTableView" else { return }
    eventsTableVC.events = self.events
  }
  
}

// MARK: LocationManagerDelegate
extension LocationInfoViewController: CLLocationManagerDelegate {
  
  func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let lastKnownLocation = locations.last where LocationManager.sharedInstance.didUpdateLocation == false else { return }
      // Make sure the location is correct
      refreshCounter += 1
      useLocationButton.titleLabel?.text = "  Searching... "
      
      // Once we have an accurate location, set it in the location manager
      if refreshCounter == 3 {
        LocationManager.sharedInstance.setLatAndLong(lastKnownLocation)
        LocationManager.sharedInstance.didUpdateLocation = true
        refreshCounter == 0
        useLocationButton.titleLabel?.text = "  Use Location  "
        if useLocationButton.selected == true {
          useLocationButton.selected = false
          DownloadManager.sharedInstance.downloadEvents(forCategory: EventCategories.Technology, completion: { (events, error) in
            self.didFetchEvents(events)
          })
        }
      }
  }
  
  func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
    if status == .AuthorizedWhenInUse {
      manager.startUpdatingLocation()
    }
  }
}
