//
//  EventsTableViewController.swift
//  Around Me - Meetup Events Nearby
//
//  Created by Evan Lewis on 4/9/16.
//  Copyright © 2016 Evan Lewis. All rights reserved.
//

import UIKit

class EventsTableViewController: UITableViewController {
  
  var events = [Event]()
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return events.count
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let eventCell = tableView.dequeueReusableCellWithIdentifier("eventCell", forIndexPath: indexPath)
    eventCell.textLabel?.text = events[indexPath.row].name
    eventCell.detailTextLabel?.text = events[indexPath.row].formattedTime
    return eventCell
  }
}