//
//  PostController.swift
//  Timeline
//
//  Created by youcef bouhafna on 2/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation
import UIKit

class PostController {
  
    
    static func fetchTimeLineForUser(user: User, completion:(post: [Post]) -> Void) {
        
    }
    
    static func addPost(image: UIImage, caption: String?, completion:(success: Bool, post: Post?) -> Void) {
        
    }
    static func postFromIdentifier(identifier: String, completion:(post: [Post]?) -> Void) {
        
    }
    
    static func postsForUser(user: User, completion:(posts: [Post]?) -> Void) {
        
    }
    
    
    
     static func deletePost(post: Post) {
        
    }
    
    static func addCommentWithTextToPost(string: String, post: Post, completion:(success: Bool, post: Post?) -> Void) {
        
    }
    
    
    
    static func deleteComment(comment: Comment, completion:(success: Bool, post: Post?) -> Void) {
        
    }
    
    static func addLikeToPost( post: Post, completion:(success: Bool, post: Post?) -> Void) {
        
    }
    
    static func deleteLike(like: Like, completion:(success: Bool, post: Post?) -> Void) {
        
    }
    
    
    static func orderPosts(post: [Post]) -> [Post] {
        return []
    }
    
    static func mockPosts() -> [Post]{
        let post1 = Post(imageEndPoint: "-K1l4125TYvKMc7rcp5e", userName: "adamlerois", caption: "", comments: ["comment1", "comment2"], likes: ["like1, like2"], identifier: "1234")
        let post2 = Post(imageEndPoint: "-K1l4125TYvKMc7rcp5e", userName: "joseph")
        return [post1, post2]
    }
    
    
    
    
    
    
}