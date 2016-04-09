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
    
    if let locationString = LocationManager.sharedInstance.locationSearchString {
      fetchEvents(forCategory: category, searchString: locationString)
    }
    
  }
  
  func fetchEvents(forCategory category: EventCategories, searchString: String) {
    let fetchEvents = FetchEvents()
    fetchEvents.fetchEventsForCategory(category, searchString: searchString) { (events, error) in
      for event in events {
        print("Name: \(event.name)")
        print("Id: \(event.id)")
        print("Group name \(event.groupName)")
        
        let formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.LongStyle
        formatter.timeStyle = .MediumStyle
        print("Time \(formatter.stringFromDate(event.time))")
        
        print("Where: \(event.venue.name)")
      }
    }
  }
}
