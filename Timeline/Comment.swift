//
//  Comment.swift
//  Timeline
//
//  Created by youcef bouhafna on 2/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation

struct Comment: Equatable, FirebaseType{
    private let userNameKey = "username"
    private let textKey = "text"
    private let postIdentifierKey = "postIdentifier"
    
    var userName: String
    var text: String
    var postIdentifier: String
    var identifier: String?
    var endpoint: String {
        return "/posts/\(self.postIdentifier)/comments/"
    }
    var jsonValue: [String: AnyObject] {
        return [userNameKey: userName, textKey: text, postIdentifierKey: postIdentifier]
    }
    init(userName: String, text: String, postIdentifier: String, identifier: String? = nil) {
        self.userName = userName
        self.text = text
        self.postIdentifier = postIdentifier
    }
    init?(json: [String : AnyObject], identifier: String) {
        guard let postIdentifier = json[postIdentifierKey] as? String,
               let text = json[textKey] as? String,
            let userName = json[userNameKey] as? String else { return nil}
            self.postIdentifier = postIdentifier
            self.userName = userName
            self.text = text
            
        
    }

}


func ==(lhs: Comment, rhs: Comment) -> Bool {
    return (lhs.userName == rhs.userName) && ( lhs.identifier == rhs.identifier)
}