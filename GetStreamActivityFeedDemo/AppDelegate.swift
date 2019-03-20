//
//  AppDelegate.swift
//  GetStreamActivityFeedDemo
//
//  Created by Alexey Bukhtin on 20/03/2019.
//  Copyright © 2019 Stream.io Inc. All rights reserved.
//

import UIKit
import GetStream
import GetStreamActivityFeed

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Setup Stream Client.
        Client.config = .init(apiKey: "2ryhd5wu24jk",
                              appId: "45210",
                              token: "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoidXNlci1vbmUifQ.-GBDqPI-6P1_x_9CRnw_URZUHaQ-2_M5fTHRKdflsR0")
        
        // Setup Stream user.
        Client.shared.getCurrentUser(typeOf: GetStreamActivityFeed.User.self) { result in
            // Current user is ready. Load timeline feed.
            if result.error == nil, let viewController = self.window?.rootViewController as? ViewController {
                viewController.reloadData()
            }
        }
        
        return true
    }
}
