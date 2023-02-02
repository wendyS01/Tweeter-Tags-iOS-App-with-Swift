//
//  TweetsTVC.swift
//  TweeterTags
//
//  Created by 宋文迪 on 12/11/2022.
//

import UIKit
class TweetsTVC: UITableViewController, UITextFieldDelegate {
    var tweets = [[TwitterTweet]]()
    
    @IBOutlet weak var twitterQueryTextField: UITextField!
    
    var twitterQueryText: String? = "#ucd" {
        didSet {
            tweets.removeAll()
            refresh()
        }
    }
    override func viewDidLoad() {
           super.viewDidLoad()
           self.twitterQueryTextField.delegate = self
           refresh()
       }
    
    private func refresh() {
        let request = TwitterRequest(search: twitterQueryText!,count: 8)
        request.fetchTweets { (tweets) -> Void in
            DispatchQueue.main.async { () -> Void in
                if tweets.count > 0 {
                    self.tweets.append(tweets)
                    self.tableView.reloadData()
                }
                print("the number of tweets section \(self.tweets.count)")
                //print("the number of tweets row \(self.tweets[0].count)")
            }
        }
    }
    
    //MARK: - Table View Data Source Delegate Methods
    
    //Asks the data source to return the number of sections in the table view.
    override func numberOfSections(in tableView: UITableView) -> Int {
        //as we know: the supplied TwitterAPI framework retrieve tweets in small batches (default 8) as [TwitterTweet], the number of section should be 8
        return tweets.count
    }
    
    // Return the number of rows for the table.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print("\(tweets[section].count)")
        return tweets[section].count
    }
    
    // Provide a cell object for each row.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       // Fetch a cell of the appropriate type.
        let tweetCell: TweetTVCell = tableView.dequeueReusableCell(withIdentifier: "tweetsCell", for: indexPath) as! TweetTVCell
       // Configure the cell’s contents.
        tweetCell.tweet = tweets[indexPath.section][indexPath.row]
       return tweetCell
    }
    
    //The text field calls this method whenever the user taps the return button.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == twitterQueryTextField {
            // dismiss the keyboard when the user taps the return button by calling the resignFirstResponder() method
            textField.resignFirstResponder()
        }
        twitterQueryText = textField.text ?? ""
        return true
    }
}


