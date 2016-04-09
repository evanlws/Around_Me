//
//  LocationManager.swift
//  Around Me - Meetup Events Nearby
//
//  Created by Evan Lewis on 4/8/16.
//  Copyright © 2016 Evan Lewis. All rights reserved.
//

import Foundation
import CoreLocation

enum LocationError: ErrorType {
  case FailedToFetchCoordinates
  case InvalidCoordinates
  case InvalidZipCode
}

class LocationManager: NSObject {
  
  static let sharedInstance = LocationManager()

  // String that contains the location data to go into the url
  var locationSearchString: String?
  // Boolean that checks if the location was updated since the view was loaded
  var didUpdateLocation = false
  
  func setLatAndLong(location: CLLocation) {
   locationSearchString = "&lat=\(location.coordinate.latitude)&lon=\(location.coordinate.longitude)"
    debugPrint("Setting lat and long \(location.coordinate.latitude), \(location.coordinate.longitude)")
  }
  
  func setZipCode(zipCode: String) throws {
    if zipCode.characters.count > 1 {
      locationSearchString = "&zip=10002"
    } else {
      throw LocationError.InvalidZipCode
    }
  }

}