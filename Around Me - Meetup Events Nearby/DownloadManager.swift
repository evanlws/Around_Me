//
//  DownloadManager.swift
//  Around Me - Meetup Events Nearby
//
//  Created by Evan Lewis on 4/7/16.
//  Copyright © 2016 Evan Lewis. All rights reserved.
//

import Foundation

// DownloadManager is a singleton that handles starting network requests
class DownloadManager {
  
  static let sharedInstance = DownloadManager()
  
  func downloadEvents(forCategory category: EventCategories, completion:(events: [Event], error: ErrorType?) -> Void) {
    if let locationString = LocationManager.sharedInstance.locationSearchString {
      let fetchEvents = FetchEvents()
        fetchEvents.fetchEventsForCategory(category, searchString: locationString) { (events, error) in
          completion(events: events, error: nil)
      }
    }
  }

}
