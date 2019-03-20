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
    
    let textToolBar = TextToolBar.make()

    override func viewDidLoad() {
        // Setup a timeline feed presenter.
        if let feedId = FeedId(feedSlug: "timeline") {
            let timelineFlatFeed = Client.shared.flatFeed(feedId)
            presenter = FlatFeedPresenter<GetStreamActivityFeed.Activity>(flatFeed: timelineFlatFeed,
                                                                          reactionTypes: [.likes, .comments])
        }
        
        super.viewDidLoad()
        setupTextToolBar()
    }
    
    func setupTextToolBar() {
        textToolBar.placeholderText = "Add a post"
        textToolBar.addToSuperview(view)
        textToolBar.sendButton.addTarget(self, action: #selector(save(_:)), for: .touchUpInside)
    }
    
    @objc func save(_ sender: UIButton) {
        // Hide the keyboard.
        view.endEditing(true)
        
        // Check that entered text is not empty
        // and get the current user, it shouldn’t be nil.
        guard !textToolBar.text.isEmpty,
            let user = GetStreamActivityFeed.User.current else {
                return
        }
        
        // Create a new post with entered text.
        let activity = GetStreamActivityFeed.Activity(actor: user, verb: "post", object: .text(textToolBar.text))
        // Clear the text field with the entered text.
        textToolBar.text = ""
        // Add the new Activity to the feed.
        presenter?.flatFeed.add(activity) { result in
            print(result)
        }
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
