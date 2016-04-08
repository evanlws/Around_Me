//
//  AppDelegate.swift
//  Around Me - Meetup Events Nearby
//
//  Created by Evan Lewis on 4/7/16.
//  Copyright © 2016 Evan Lewis. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {

  var window: UIWindow?

  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    // Override point for customization after application launch.
    DownloadManager.sharedInstance.startDownload(forCategory: EventCategories.Technology)
    return true
  }

}

