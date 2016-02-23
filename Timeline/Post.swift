//
//  Post.swift
//  Timeline
//
//  Created by youcef bouhafna on 2/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation

struct Post: Equatable {
    var imageEndPoint: String
    var caption: String?
    var userName: String
    var comments: [String]
    var likes: [String]
    var identifier: String?
    
    init(imageEndPoint: String, userName: String, caption: String? = nil, comments: [String] = [], likes: [String] = [], identifier: String? = nil) {
        self.imageEndPoint = imageEndPoint
        self.comments = comments
        self.likes = likes
        self.userName = userName
        
    }
    
}

func ==(lhs: Post, rhs: Post) -> Bool {
    return ( lhs.userName == rhs.userName) && ( lhs.identifier == rhs.identifier)
}