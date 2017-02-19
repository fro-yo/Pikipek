//
//  Tweet.swift
//  Pikipek
//
//  Created by Ajeya Rengarajan on 2/18/17.
//  Copyright © 2017 Ajeya Rengarajan. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    
    var text: String?
    var timeStamp: Date?
    var retweetCount: Int = 0
    var favouriteCount: Int = 0
    
    init (dictionary: NSDictionary) {
        
        text = dictionary["text"] as? String
        retweetCount = ( dictionary["retweet_count"] as? Int ) ?? 0
        favouriteCount = ( dictionary ["favourites_count"] as? Int ) ?? 0;
        
        let timeStampString = dictionary["created_at"] as? String
        if let timeStampString = timeStampString {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timeStamp = formatter.date(from: timeStampString)
        }
    }
    
    class func getTweetArray (dictionaries: [NSDictionary]) -> [Tweet] {
        
        var tweetArray = [Tweet]()
        
        for tweetDict in dictionaries {
            let tweet = Tweet (dictionary: tweetDict)
            tweetArray.append(tweet)
        }
        
        return tweetArray
    }

}
