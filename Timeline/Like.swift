//
//  Like.swift
//  Timeline
//
//  Created by youcef bouhafna on 2/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation


struct Like: Equatable, FirebaseType  {
    private let postIdentifierKey = "postIdentifier"
    private let userNameKey = "userName"
    var endpoint: String {
        return "/posts/\(self.postIdentifier)/likes/"
    }
    
    var jsonValue: [String: AnyObject] {
        return [postIdentifierKey: postIdentifier, userNameKey: userName]
    }
    var userName: String
    var postIdentifier: String
    var identifier: String?
    init(userName: String, postIdentifier: String, identifier: String? = nil) {
        self.userName = userName
        self.postIdentifier = postIdentifier
    }
    init?(json: [String : AnyObject], identifier: String) {
        guard let userName = json[userNameKey] as? String,
            let postIdentifier = json[postIdentifierKey] as? String else {return nil}
        
        self.postIdentifier = postIdentifier
        self.userName = userName
        
        
    }
}

func ==(lhs: Like, rhs: Like) -> Bool {
    return (lhs.userName == rhs.userName) && ( lhs.identifier == rhs.identifier)
}