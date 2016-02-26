//
//  UserController.swift
//  Timeline
//
//  Created by youcef bouhafna on 2/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation
class UserController {
    
    let currentUser: User! = nil
    
    static let sharedController = UserController()
    static func userForIdentifier(identifier: String, completion:(user: User?) -> Void) {
        
    }
    
    
    static func fetchAllUsers(completion:(users: [User]) -> Void) {
        
    }
    
    static func followUser(user: User, completion:(success: Bool) -> Void) {
        
    }
    
    
    
    static func unfollowUser(user: User, completion:(success: Bool) -> Void) {
        
    }
    
    static func userFollowUser(user: User, checkingUser: User, completion:(follows: Bool) -> Void) {
        
    }
    
    static func followedByUser(user: User, completion:(followed: [User]?) -> Void) {
        
    }
    
    static func authenticateUser(email: String, password: String, completion:(success: Bool, user: User?) -> Void) {
        
    }
    static func createUser( email: String, password: String, bio: String?, url: String?, completion:(success: Bool, user: User?) -> Void) {
        
    }
    
    
    static func updateUser(user: User, userName: String, bio: String?, url: String?, completion:(success: Bool, user: User?) -> Void) {
        
    }
    
    
    
    static func mockUsers() ->[User] {
        let user1 = User(userName: "youcef", bio: "love traveling", url: "http://google.com", identifier: "")
        let user2 = User(userName: "lynn", bio: "business woman", url: "http://google.fr", identifier: "")
        let user3 = User(userName: "Al", bio: "handy man", url: "http://google.uk", identifier: "")
        let user4 = User(userName: "michel", bio: "real estate", url: "N/A", identifier: "")
        return [user1, user2, user3, user4]
    }
    
    
    
    
    
    
}