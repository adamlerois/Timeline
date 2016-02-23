//
//  Like.swift
//  Timeline
//
//  Created by youcef bouhafna on 2/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation


struct Like: Equatable {
    var userName: String
    var postIdentifier: String
    var identifier: String?
    init(userName: String, postIdentifier: String, identifier: String? = nil) {
       self.userName = userName
        self.postIdentifier = postIdentifier
    }
}

func ==(lhs: Like, rhs: Like) -> Bool {
    return (lhs.userName == rhs.userName) && ( lhs.identifier == rhs.identifier)
}