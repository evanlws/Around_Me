//
//  Venue.swift
//  Around Me - Meetup Events Nearby
//
//  Created by Evan Lewis on 4/8/16.
//  Copyright © 2016 Evan Lewis. All rights reserved.
//

import Foundation

class Venue {
  
  let id: Int
  let name: String
  let country: String
  let city: String
  let address: String
  let state: String?
  
  init(id: Int, name: String, country: String, city: String, address: String, state: String?) {
    self.id = id
    self.name = name
    self.country = country
    self.city = city
    self.address = address
    self.state = state
  }
  
}