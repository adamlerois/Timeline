//
//  Post.swift
//  Timeline
//
//  Created by youcef bouhafna on 2/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation

struct Post: Equatable, FirebaseType {
    private let userNameKey = "userName"
    private let imageEndpointKey = "imageEndpoint"
    private let captionKey = "caption"
    private let commentsKey = "comments"
    private let likesKey = "likes"
    
    var endpoint: String {
        return "posts"
    }
    var jsonValue: [String: AnyObject] {
        
        // ask James about that tomorrow  why we have to assign dictionary to json
        var json: [String: AnyObject] = [userNameKey: userName, imageEndpointKey: imageEndPoint, commentsKey: comments.map({$0.jsonValue}), likesKey: likes.map({$0.jsonValue})]
        if let caption = caption {
            json.updateValue(caption, forKey: captionKey)
        }
        return json
    }
    
    var imageEndPoint: String
    var caption: String?
    var userName: String
    var comments: [Comment]
    var likes: [Like]
    var identifier: String?
    
    init(imageEndPoint: String, userName: String, caption: String? = nil, comments: [Comment] = [], likes: [Like] = [], identifier: String? = nil) {
        self.imageEndPoint = imageEndPoint
        self.comments = comments
        self.likes = likes
        self.userName = userName
        
    }
    init?(json: [String : AnyObject], identifier: String) {
        guard let imageEndPoint = json[imageEndpointKey] as? String,
            let userName = json[userNameKey] as? String else {return nil}
        
        self.imageEndPoint = imageEndPoint
        self.userName = userName
        self.caption = json[captionKey] as? String
        self.identifier = identifier
        
        if let commentDictionaries = json[commentsKey] as? [String: AnyObject] {
            self.comments = commentDictionaries.flatMap({Comment(json: $0.1 as! [String : AnyObject], identifier: $0.0)})
            
        }else { self.comments = []
        }
        
        if let likesDictionaries = json[likesKey] as? [String: AnyObject] {
            self.likes = likesDictionaries.flatMap({Like(json: $0.1 as! [String: AnyObject], identifier: $0.0)})
        }else { self.likes = []
        }
    }
    
}


func ==(lhs: Post, rhs: Post) -> Bool {
    return ( lhs.userName == rhs.userName) && ( lhs.identifier == rhs.identifier)
}