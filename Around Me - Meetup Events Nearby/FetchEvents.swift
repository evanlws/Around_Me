//
//  FetchEvents.swift
//  Around Me - Meetup Events Nearby
//
//  Created by Evan Lewis on 4/7/16.
//  Copyright © 2016 Evan Lewis. All rights reserved.
//
// Class responsible for handling the network request, and after passes it back to the DownloadManager

import Foundation

enum EventCategories: String {
  case Technology = "technology"
}

class FetchEvents : NSOperation, NSURLSessionDelegate {
  
  func fetchEventsForCategory(category: EventCategories, searchString: String, completion:(events: [Event], error: ErrorType?) -> Void) {
    
    let urlPath = "https://api.meetup.com/2/open_events?key=267d5582f6e8275b405f25a6a7c3f&sign=true&photo-host=secure\(searchString)&topic=\(category.rawValue)&page=50"
    
    // Make sure we have a valid url
    guard let url = NSURL(string: urlPath) else {
      completion(events: [Event](), error: NSError(domain: "Error, url is invalid", code: 100, userInfo: nil ))
      return
    }
    
    debugPrint("Trying URL: \(url.absoluteString)")
    
    // Create the session request
    let request = NSMutableURLRequest(URL:url)
    let session = NSURLSession.sharedSession()
    // Start the session
    let task = session.dataTaskWithRequest(request) {
      (data, response, error) -> Void in
      
      let httpResponse = response as! NSHTTPURLResponse
      let statusCode = httpResponse.statusCode
      
      if (statusCode == 200) {
        // If the JSON file downloaded successfully, create model objects
        do {
          
          let json = try NSJSONSerialization.JSONObjectWithData(data!, options:.AllowFragments)
          
          var events = [Event]()
          
          if let results = json["results"] as? [[String: AnyObject]] {
            
            for result in results {
              // I decided to make venues and groups required. It will skip over the entries that do not have what is listed below
              guard let id = result["id"] as? String else { continue }
              guard let name = result["name"] as? String else { continue }
              guard let time = result["time"] as? Int else { continue }
              guard let duration = result["duration"] as? Int else { continue }
              guard let venue = result["venue"] as? NSDictionary else { continue }
              guard let group = result["group"] as? NSDictionary else { continue }
              
              guard let groupName = group["name"] as? String else { continue }
              
              guard let venueName = venue["name"] as? String,
                let venueId = venue["id"] as? Int,
                let country = venue["localized_country_name"]  as? String,
                let city = venue["city"] as? String,
                let address = venue["address_1"] as? String,
                let state = venue["state"] as? String else { continue }
              
              // Create the object based on the data
              let venueItem = Venue(id: venueId, name: venueName, country: country, city: city, address: address, state: state)
              
              // Convert the time integer to NSDate
              let epochSeconds = Double(time / 1000)
              let epochSecondsTimeInterval = NSTimeInterval(epochSeconds)
              let utcDate = NSDate(timeIntervalSince1970: epochSecondsTimeInterval)
              
              // Create the event item
              let eventItem = Event(id: id, time: utcDate, duration: NSTimeInterval(duration), name: name, groupName: groupName, venue: venueItem)
              
              events.append(eventItem)
            }
            dispatch_async(dispatch_get_main_queue(), {
              completion(events: events, error: nil)
            })
          }
          
        } catch {
          dispatch_async(dispatch_get_main_queue(), {
            print("Error with Json: \(error)")
            completion(events: [Event](), error: error)
          })
        }
      } else {
        dispatch_async(dispatch_get_main_queue(), {
          print("ERROR: \(statusCode)")
          completion(events: [Event](), error: error)
        })
      }
    }
    task.resume()
  }
  
}
