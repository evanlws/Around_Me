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
  
  func didFetchEvents(events: [Event]) {
    print("Did receive \(events.count) events")
  }
  
}

// MARK: LocationManagerDelegate
extension LocationInfoViewController: CLLocationManagerDelegate {
  
  func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    if let lastKnownLocation = locations.last where LocationManager.sharedInstance.didUpdateLocation == false {
      refreshCounter += 1
      // Once we have an accurate location, start the download
      if refreshCounter == 3 {
        LocationManager.sharedInstance.setLatAndLong(lastKnownLocation)
        LocationManager.sharedInstance.didUpdateLocation = true
        refreshCounter == 0
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
