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
  
  override func awakeFromNib() {
    
    //Load xib files
    let eventNib = UINib(nibName: "EventTableViewCell", bundle: nil)
    tableView.registerNib(eventNib, forCellReuseIdentifier: "eventCell")
    
    super.awakeFromNib()
    
  }
  
  override func viewDidAppear(animated: Bool) {
    self.activityIndicator.startAnimating()
    DownloadManager.sharedInstance.downloadEvents(forCategory: EventCategories.Technology) { (events, error) in
      self.events = events
      self.tableView.reloadData()
      self.activityIndicator.stopAnimating()
    }
  }
  
  override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return 100
  }
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return events.count
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let event = events[indexPath.row]
    let eventCell = tableView.dequeueReusableCellWithIdentifier("eventCell", forIndexPath: indexPath) as! EventTableViewCell
    eventCell.nameLabel.text = event.name
    eventCell.locationLabel.text = event.venue.address
    eventCell.timeLabel.text = event.formattedTime
    return eventCell
  }
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
  }
  
  override func viewWillDisappear(animated: Bool) {
    self.activityIndicator.stopAnimating()
  }
}