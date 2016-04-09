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
    // When the view loads, start the download
    DownloadManager.sharedInstance.downloadEvents(forCategory: EventCategories.Technology) { (events, error) in
      self.events = events
      self.tableView.reloadData()
      self.activityIndicator.stopAnimating()
      
      if events.count == 0 {
        // Go back if there aren't any events
        let alertController = UIAlertController(title: "No events found for this location", message: "Sorry, we couldn't find any upcoming events in your area", preferredStyle: .Alert)
        let alertAction = UIAlertAction(title: "Ok", style: .Default, handler: { (action) in
          self.navigationController?.popViewControllerAnimated(true)
        })
        alertController.addAction(alertAction)
        self.presentViewController(alertController, animated: true, completion: nil)
      }
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
    // Displays information for each event
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