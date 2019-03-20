//
//  ViewController.swift
//  GetStreamActivityFeedDemo
//
//  Created by Alexey Bukhtin on 20/03/2019.
//  Copyright © 2019 Stream.io Inc. All rights reserved.
//

import UIKit
import GetStream
import GetStreamActivityFeed

class ViewController: FlatFeedViewController<GetStreamActivityFeed.Activity> {

    override func viewDidLoad() {
        // Setup a timeline feed presenter.
        if let feedId = FeedId(feedSlug: "timeline") {
            let timelineFlatFeed = Client.shared.flatFeed(feedId)
            presenter = FlatFeedPresenter<GetStreamActivityFeed.Activity>(flatFeed: timelineFlatFeed,
                                                                          reactionTypes: .likes)
        }
        
        super.viewDidLoad()
    }
}
