//
//  Event.swift
//  Around Me - Meetup Events Nearby
//
//  Created by Evan Lewis on 4/7/16.
//  Copyright © 2016 Evan Lewis. All rights reserved.
//

import Foundation

class Event {

  let id: String
  let time: NSDate
  let name: String
  let groupName: String
  let venue: Venue
  
  init(id: String, time: NSDate, name: String, groupName: String, venue: Venue) {
    self.id = id
    self.time = time
    self.name = name
    self.groupName = groupName
    self.venue = venue
  }
  
  
}