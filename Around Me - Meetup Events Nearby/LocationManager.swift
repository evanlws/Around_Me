//
//  LocationManager.swift
//  Around Me - Meetup Events Nearby
//
//  Created by Evan Lewis on 4/8/16.
//  Copyright © 2016 Evan Lewis. All rights reserved.
//
// Class responsible for updating the users location, based upon their search preference wether it be zip code or lat and lon

import Foundation
import CoreLocation

class LocationManager: NSObject {
  
  static let sharedInstance = LocationManager()

  // String that contains the location data to go into the url
  var locationSearchString: String?
  // Boolean that checks if the location was updated since the view was loaded
  var didUpdateLocation = false
  
  func setLatAndLong(location: CLLocation) {
   locationSearchString = "&lat=\(location.coordinate.latitude)&lon=\(location.coordinate.longitude)"
    debugPrint("Updated location: \(location.coordinate.latitude), \(location.coordinate.longitude)")
  }
  
  func setZipCode(zipCode: String) {
    if zipCode.characters.count > 1 {
      locationSearchString = "&zip=\(zipCode)"
      debugPrint("Updated zip code: \(zipCode)")
    }
  }

}