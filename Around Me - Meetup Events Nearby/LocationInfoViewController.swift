//
//  LocationInfoViewController.swift
//  Around Me - Meetup Events Nearby
//
//  Created by Evan Lewis on 4/8/16.
//  Copyright © 2016 Evan Lewis. All rights reserved.
//

import UIKit
import CoreLocation

class LocationInfoViewController: UIViewController {
  
  var locationManager = CLLocationManager()
  
  // The didUpdateLocations function will update multiple times in order to get the correct location. The first few are usually from a previous location
  var refreshCounter = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    locationManager.delegate = self
    if CLLocationManager.authorizationStatus() == .NotDetermined {
      locationManager.requestWhenInUseAuthorization()
    }
  }
  
  override func viewDidAppear(animated: Bool) {
    LocationManager.sharedInstance.didUpdateLocation = false
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
}

// MARK: LocationManagerDelegate
extension LocationInfoViewController: CLLocationManagerDelegate {
  
  func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    if let lastKnownLocation = locations.last where LocationManager.sharedInstance.didUpdateLocation == false {
      refreshCounter += 1
      print("Did update location: \(lastKnownLocation.coordinate.latitude), \(lastKnownLocation.coordinate.longitude)")
      // Once we have an accurate location, start the download
      if refreshCounter == 5 {
        LocationManager.sharedInstance.setLatAndLong(lastKnownLocation)
        LocationManager.sharedInstance.didUpdateLocation = true
        refreshCounter == 0
        DownloadManager.sharedInstance.startDownload(forCategory: EventCategories.Technology)
      }
    }
  }
  
  func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
    if status == .AuthorizedWhenInUse {
      manager.startUpdatingLocation()
    }
  }
}
