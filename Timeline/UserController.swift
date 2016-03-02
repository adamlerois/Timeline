//
//  UserController.swift
//  Timeline
//
//  Created by youcef bouhafna on 2/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation
class UserController {
    private let userKey = "user"
    
    
    var currentUser: User! {
        get {
            
            guard let uid = FirebaseController.base.authData?.uid,
                let userDictionary = NSUserDefaults.standardUserDefaults().valueForKey(userKey) as? [String: AnyObject] else {
                    
                    return nil
            }
            
            return User(json: userDictionary, identifier: uid)
        }
        
        set {
            
            if let newValue = newValue {
                NSUserDefaults.standardUserDefaults().setValue(newValue.jsonValue, forKey: userKey)
                NSUserDefaults.standardUserDefaults().synchronize()
            } else {
                NSUserDefaults.standardUserDefaults().removeObjectForKey(userKey)
                NSUserDefaults.standardUserDefaults().synchronize()
            }
        }
    }
    
    
    static let sharedController = UserController()
    static func userForIdentifier(identifier: String, completion:(user: User?) -> Void) {
        FirebaseController.dataAtEndpoint(identifier) { (data) -> Void in
            if let json = data as? [String: AnyObject] {
                let user = User(json: json, identifier: identifier)
                completion(user: user)
            }else{
                completion(user: nil)
            }
        }
    }
    
    
    static func fetchAllUsers(completion:(users: [User]) -> Void) {
        FirebaseController.dataAtEndpoint("users") { (data) -> Void in
            if let json = data as? [String: AnyObject] {
                // ask nathan about the flatMap
                let users = json.flatMap({User(json: $0.1 as! [String : AnyObject], identifier: $0.0)})
                
                completion(users: users)
                
            }else {
                completion(users: [])
            }
        }
        
    }
    
    static func followUser(user: User, completion:(success: Bool) -> Void) {
        
        FirebaseController.base.childByAppendingPath("/users/(sharedController.currentUser.identifier!)/follows/(user.identifier!)").setValue(true)
        
        completion(success: true)
    }
    
    
    
    
    
    static func unfollowUser(user: User, completion:(success: Bool) -> Void) {
        
        FirebaseController.base.childByAppendingPath("/users/(sharedController.currentUser.identifier!)/follows/(user.identifier!)").removeValue()
        completion(success: true)
    }
    
    static func userFollowUser(user: User, checkingUser: User, completion:(follows: Bool) -> Void) {
        
        FirebaseController.dataAtEndpoint("/users/(sharedController.currentUser.identifier!)/follows/") { (data) -> Void in
            if let data = data {
                completion(follows: true)
            }else {
                completion(follows: false)
            }
            
            
        }
        
    }
    
    static func followedByUser(user: User, completion:(followed: [User]?) -> Void) {
        FirebaseController.dataAtEndpoint("/users/(sharedController.currentUser.identifier!)/follows/(user.identifier!)"){ (data) -> Void in
            
        }
    }
    
    
    static func authenticateUser(email: String, password: String, completion:(success: Bool, user: User?) -> Void) {
        completion(success: true, user: mockUsers()[0])
        
    }
    static func createUser( email: String, password: String, bio: String?, url: String?, completion:(success: Bool, user: User?) -> Void) {
        completion(success: true, user: mockUsers()[0])
        
    }
    
    
    static func updateUser(user: User, userName: String, bio: String?, url: String?, completion:(success: Bool, user: User?) -> Void) {
        completion(success: true, user: mockUsers()[0])
        
    }
    static func logoutCurrentUser(){
        
    }
    
    
    static func mockUsers() ->[User] {
        let user1 = User(userName: "youcef", bio: "love traveling", url: "http://google.com", identifier: "")
        let user2 = User(userName: "lynn", bio: "business woman", url: "http://google.fr", identifier: "")
        let user3 = User(userName: "Al", bio: "handy man", url: "http://google.uk", identifier: "")
        let user4 = User(userName: "michel", bio: "real estate", url: "N/A", identifier: "")
        return [user1, user2, user3, user4]
    }
    
    
    
    
    
    
}