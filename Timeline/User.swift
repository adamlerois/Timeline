//
//  File.swift
//  Timeline
//
//  Created by youcef bouhafna on 2/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation

struct User: Equatable {
    var userName: String
    var bio: String?
    var url: String?
    var identifier: String?
    
    init(userName: String, bio: String? = nil, url: String? = nil, identifier: String?) {
        
        self.userName = userName
        self.identifier = identifier
    }
}

    func ==(lhs: User, rhs: User) -> Bool {
        return (lhs.userName == rhs.userName) && (lhs.identifier == rhs.identifier)
    
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    