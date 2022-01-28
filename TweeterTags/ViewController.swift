//
//  ViewController.swift
//  TweeterTags
//
//  Created by COMP47390 on 28/01/2022.
//  Copyright © 2020 COMP47390. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var textLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let request = TwitterRequest(search: "#UCD", count: 8)
        self.textLabel?.text = "Query: #UCD"

        request.fetchTweets { (tweets) -> Void in
            DispatchQueue.main.async { () -> Void in
                // check log in console
                for tweet in tweets {
                    print(tweet.text)
                }
                // update label
                self.textLabel?.text = (self.textLabel?.text ?? "") + "\nFetched \(tweets.count) tweets"
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

