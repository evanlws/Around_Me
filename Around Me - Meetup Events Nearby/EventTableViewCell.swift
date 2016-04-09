//
//  EventTableViewCell.swift
//  Around Me - Meetup Events Nearby
//
//  Created by Evan Lewis on 4/9/16.
//  Copyright © 2016 Evan Lewis. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {
  
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var locationLabel: UILabel!
  @IBOutlet weak var timeLabel: UILabel!
  @IBOutlet weak var innerView: UIView!
 
  override func awakeFromNib() {
    innerView.layer.shadowColor = UIColor.blackColor().CGColor;
    innerView.layer.shadowOffset = CGSizeMake(1, 2);
    innerView.layer.shadowOpacity = 0.4;
    innerView.layer.shadowRadius = 1.0;
  }
  
  // Set style when the user taps on a cell
  override func setHighlighted(highlighted: Bool, animated: Bool) {
    if highlighted {
      innerView.layer.shadowColor = UIColor.clearColor().CGColor;
    } else {
      innerView.layer.shadowColor = UIColor.blackColor().CGColor;
    }
  }
  
  override func setSelected(selected: Bool, animated: Bool) {
    if selected {
      innerView.layer.shadowColor = UIColor.clearColor().CGColor;
    } else {
      innerView.layer.shadowColor = UIColor.blackColor().CGColor;
    }
  }
}
