//
//  LoginViewController.swift
//  Pikipek
//
//  Created by Ajeya Rengarajan on 2/17/17.
//  Copyright © 2017 Ajeya Rengarajan. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func loginButton(_ sender: Any) {
        
        let twitterClient = BDBOAuth1SessionManager (baseURL: URL(string: "https://api.twitter.com"), consumerKey: "Ei2yvsY4UqCICBxWitWTdZnpK", consumerSecret:"SPHmekVh1thRGAMZB27kA9H9EY2gnT0p34Xv7QcA36VmXOaqpu" );
        twitterClient?.deauthorize()
        twitterClient?.fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: URL(string:"pikipek://oauth"), scope: nil,
            success: { (requestToken: BDBOAuth1Credential?) -> Void in
                        print ("got a request token!")
                        // bug fix 1: requestToken?.token not unwrapped using ((requestToken?.token)!)
                        let url = URL (string: "https://api.twitter.com/oauth/authorize?oauth_token=\((requestToken?.token)!)")
                        UIApplication.shared.open(url!, options: [:],
                                                  completionHandler: { (success: Bool) -> Void in
                                                    print ("successfully opened twitter authorization")
                                                  }
                        )
                     },
            failure: { (error: Error?) -> Void in
                        print ("failure");
                     }
        )
        
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
