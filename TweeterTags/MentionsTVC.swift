//
//  FourMentions.swift
//  TweeterTags
//
//  Created by 宋文迪 on 18/11/2022.
//
import Foundation
import UIKit
//reference from Swift 5 - How to Create UITableView with multiple sections in iOS https://www.youtube.com/watch?v=AHY09z-XS9s
class Section {
    var header: String
    var mentions: [Any]
    init(header: String,mentions:[Any]) {
        self.header = header
        self.mentions = mentions
    }
}

class MentionsTVC: UITableViewController {
    var tweet: TwitterTweet!
    var fourSections: [Section]!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func updateFourSections() {
        let media = tweet.media
        let urls = tweet.urls
        let hashtags = tweet.hashtags
        let users = tweet.userMentions
        if !media.isEmpty {
            fourSections.append(Section(header: "Images",mentions: media))
        }
        if !urls.isEmpty {
            fourSections.append(Section(header:"URLs",mentions:urls))
        }
        if !hashtags.isEmpty {
            fourSections.append(Section(header:"Hashtags",mentions: hashtags))
        }
        if !users.isEmpty {
            fourSections.append(Section(header: "Users", mentions: users))
        }
    }
    
    
    //MARK: - Table View Data Source Delegate Methods
    
    //Asks the data source to return the number of sections in the table view.
    override func numberOfSections(in tableView: UITableView) -> Int {
        //as we know: the supplied TwitterAPI framework retrieve tweets in small batches (default 8) as [TwitterTweet], the number of section should be 8
        return fourSections.count
    }
    
    // Return the number of rows for the table.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fourSections[section].mentions.count
    }
    
    // Provide a cell object for each row.

    
}

