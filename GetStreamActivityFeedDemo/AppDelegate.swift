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
        Client.config = .init(apiKey: "<#API_KEY#>",
                              appId: "<#APP_ID#>",
                              logsEnabled: true)
        
        Client.shared.setupUser(GetStreamActivityFeed.User(name: "<#USER_NAME#>",
                                                           id: "<#USER_ID#>"),
                                token: "<#USER_TOKEN#>") { (result) in
                                    guard result.error == nil else {
                                        preconditionFailure("Cannot setup user: \(result.error!)")
                                    }
                                    if let viewController = self.window?.rootViewController as? ViewController {
                                        viewController.reloadData()
                                    }
        }
        
        return true
    }
}
