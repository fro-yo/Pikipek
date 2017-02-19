//
//  TwitterClient.swift
//  Pikipek
//
//  Created by Ajeya Rengarajan on 2/18/17.
//  Copyright © 2017 Ajeya Rengarajan. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {
    
    static var client = TwitterClient (baseURL: URL(string: "https://api.twitter.com"), consumerKey: "Ei2yvsY4UqCICBxWitWTdZnpK", consumerSecret:"SPHmekVh1thRGAMZB27kA9H9EY2gnT0p34Xv7QcA36VmXOaqpu" )!;

    var loginSuccess: (() -> ())?
    var loginFailure: ((Error) -> ())?
    
    /*****************
     * Tweets 
     *****************/
    func getTweets (success: @escaping (([Tweet]) -> ()), failure: @escaping ((Error) -> ())) {
        
        get("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: {
            (task:URLSessionDataTask, response: Any?) in
            
            let tweets = response as? [NSDictionary]
            let tweetArray = Tweet.getTweetArray(dictionaries: tweets!)
            success (tweetArray)
            
        }, failure: {
            (task: URLSessionDataTask?, error: Error) in
            print ("error in fetching tweets")
            failure (error)
        })
    }
    
    
    /*****************
     * Users
     *****************/
    func getUser (success: @escaping ((User) -> ()), failure: @escaping ((Error) -> ())) {
        
        get("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: {
            (task:URLSessionDataTask, response: Any?) in
            
            let userInfo = response as? NSDictionary
            let user = User (dictionary: userInfo!)
            
            success (user)
            
        }, failure: {
            (task: URLSessionDataTask?, error: Error) in
            print ("error: \(error.localizedDescription)")
            failure (error)
        })
    }
    
    
    /**
     * login - gets request token, callback handles getting access token
     */
    func login (success: @escaping (() -> ()), failure: @escaping ((Error) -> ())) {
        loginSuccess = success
        loginFailure = failure
        
        TwitterClient.client.deauthorize()
        TwitterClient.client.fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: URL(string:"pikipek://oauth"), scope: nil,
            success: { (requestToken: BDBOAuth1Credential?) -> Void in
                        print ("got a request token!")
                        // bug fix 1: requestToken?.token not unwrapped using ((requestToken?.token)!)
                        let url = URL (string: "https://api.twitter.com/oauth/authorize?oauth_token=\((requestToken?.token)!)")
                        UIApplication.shared.open(url!, options: [:], completionHandler: nil)
                     },
            failure: { (error: Error?) -> Void in
                        print ("Error in getting request token: \(error?.localizedDescription)");
                        self.loginFailure?(error!)
                     }
        )
    }
    
    /**
     * handleOpenUrl - handles the callback from fetchRequestToken
     *                 and gets the access token using hte request token
     */
    
    func handleOpenUrl (url: URL) {
        let requestToken = BDBOAuth1Credential (queryString: url.query)
        TwitterClient.client.fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: requestToken, success:
            {(accessToken: BDBOAuth1Credential?) -> Void in
                self.loginSuccess?()
        }
        , failure: {
                (error: Error?) -> Void in
                print ("error \(error?.localizedDescription)")
                self.loginFailure?(error!)
        })
    }
    
    
}
