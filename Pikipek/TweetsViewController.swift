//
//  TweetsViewController.swift
//  Pikipek
//
//  Created by Ajeya Rengarajan on 2/19/17.
//  Copyright © 2017 Ajeya Rengarajan. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController {

    var tweets: [Tweet] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        TwitterClient.client.getTweets(success: { (tweetArray: [Tweet]) in
            self.tweets = tweetArray
            print (tweetArray.count)
            for tweet in tweetArray{
                print ("\(tweet.text!)")
            }
        }) { (error: Error) in
            print ("error getting tweets: \(error.localizedDescription)")
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
