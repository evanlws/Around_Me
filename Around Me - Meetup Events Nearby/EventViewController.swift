//
//  EventViewController.swift
//  Around Me - Meetup Events Nearby
//
//  Created by Evan Lewis on 4/9/16.
//  Copyright © 2016 Evan Lewis. All rights reserved.
//

import UIKit

class EventViewController: UIViewController {
  
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var groupNameLabel: UILabel!
  @IBOutlet weak var venueNameLabel: UILabel!
  @IBOutlet weak var locationLabel: UILabel!
  @IBOutlet weak var cityStateLabel: UILabel!
  
  @IBOutlet weak var eventByLabel: UILabel!
  @IBOutlet weak var whereLabel: UILabel!
  var event: Event?
  
  override func viewDidAppear(animated: Bool) {
    guard let event = event else { return }
    nameLabel.text = event.name
    dateLabel.text = event.formattedTime
    groupNameLabel.text = event.groupName
    venueNameLabel.text = event.venue.name
    locationLabel.text = event.venue.address
    cityStateLabel.text = "\(event.venue.city), \(event.venue.state) \(event.venue.country)"
    
    UIView.animateWithDuration(0.4) { 
      self.nameLabel.alpha = 1.0
      self.dateLabel.alpha = 1.0
      self.groupNameLabel.alpha = 1.0
      self.venueNameLabel.alpha = 1.0
      self.locationLabel.alpha = 1.0
      self.cityStateLabel.alpha = 1.0
      
      self.eventByLabel.alpha = 1.0
      self.whereLabel.alpha = 1.0
    }
  }

}
