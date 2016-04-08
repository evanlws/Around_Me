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
  
  func startDownload(forCategory category: EventCategories) {
    let fetchEvents = FetchEvents()
    fetchEvents.fetchEventsForCategory(category) { (events, error) in
      for event in events {
        print(event.name)
        print(event.id)
        print(event.groupName)
        print(event.time)
        print(event.venue.name)
      }
    }
  }
}
