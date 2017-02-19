//
//  User.swift
//  Pikipek
//
//  Created by Ajeya Rengarajan on 2/18/17.
//  Copyright © 2017 Ajeya Rengarajan. All rights reserved.
//

import UIKit

class User: NSObject {
    
    var name: String?
    var screenName: String?
    var profileImageUrl: URL?
    var tagline: String?
    
    init (dictionary: NSDictionary) {
        
        name = dictionary ["name"] as? String
        screenName = dictionary ["screen_name"] as? String
        
        let profileUrlString = dictionary ["profile_image_url_https"] as? String
        if let url = profileUrlString {
            profileImageUrl = URL (string: url)
        }
        
        tagline = dictionary ["description"] as? String
    }

}
