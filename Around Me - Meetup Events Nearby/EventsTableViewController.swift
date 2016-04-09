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
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  
  override func viewDidAppear(animated: Bool) {
    self.activityIndicator.startAnimating()
    DownloadManager.sharedInstance.downloadEvents(forCategory: EventCategories.Technology) { (events, error) in
      self.events = events
      self.tableView.reloadData()
      self.activityIndicator.stopAnimating()
    }
  }
  
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
  
  override func viewWillDisappear(animated: Bool) {
    self.activityIndicator.stopAnimating()
  }
}