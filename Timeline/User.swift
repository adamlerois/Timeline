//
//  File.swift
//  Timeline
//
//  Created by youcef bouhafna on 2/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation

struct User: Equatable, FirebaseType {
    
    private let userNameKey = "userName"
    private let bioKey = "bio"
    private let urlKey = "url"
    var endpoint: String {
        return "users"
    }
    var jsonValue: [String:AnyObject] {
        var json: [String:AnyObject] = [userNameKey: userName]
        if let bio = bio {
            json.updateValue(bio, forKey: bioKey)
        }
        if let url = url {
            json.updateValue(url, forKey: urlKey)
        }
        return json
        
    }
    var userName: String
    var bio: String?
    var url: String?
    var identifier: String?
    
    init(userName: String, bio: String? = nil, url: String? = nil, identifier: String?) {
        
        self.userName = userName
        self.identifier = identifier
    }
    init?(json: [String : AnyObject], identifier: String) {
        guard let userName = json[userNameKey] as? String else {return nil}
        self.userName = userName
        self.bio = json[bioKey] as? String
        self.url = json[urlKey] as? String
    }
}

    func ==(lhs: User, rhs: User) -> Bool {
        return (lhs.userName == rhs.userName) && (lhs.identifier == rhs.identifier)
    
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    