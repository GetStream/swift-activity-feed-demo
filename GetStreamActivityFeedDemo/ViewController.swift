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
                                                                          reactionTypes: [.likes, .comments])
        }
        
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            // Create a detail view controller.
            let detailViewController = DetailViewController<GetStreamActivityFeed.Activity>()
            // Set the activity presenter from the selected cell.
            detailViewController.activityPresenter = activityPresenter(in: indexPath.section)
            // Set sections we want to show the activity itself and comments.
            detailViewController.sections = [.activity, .comments]
            // Present the detail view controller with UINavigationController
            // to use the navigation bar to return back.
            present(UINavigationController(rootViewController: detailViewController), animated: true)
        } else {
            // Keep the default behaviour for over rows in the table view.
            super.tableView(tableView, didSelectRowAt: indexPath)
        }
    }
}
