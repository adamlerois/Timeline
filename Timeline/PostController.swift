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
  
    static func fetchTimeLineForUser(user: User, completion:(posts: [Post]) -> Void) {
        UserController.followedByUser(user) { (followed) -> Void in
            let posts: [Post] = []
            let tunnel = dispatch_group_create()
            dispatch_group_enter(tunnel)
            postsForUser(UserController.sharedController.currentUser, completion: { (posts) -> Void in
             
                dispatch_group_leave(tunnel)
            })
            if let followed = followed {
                for user in followed {
                    dispatch_group_enter(tunnel)
                    postsForUser(user, completion: { (posts) -> Void in
                        dispatch_group_leave(tunnel)
                    })
                }
            }
            dispatch_group_notify(tunnel, dispatch_get_main_queue(), { () -> Void in
                let orderedPosts = orderPosts(posts)
                completion(posts: orderedPosts)
            })
        }
    }
    
    static func addPost(image: UIImage, caption: String?, completion:(success: Bool, post: Post?) -> Void) {
        
        ImageController.uploadImage(image) { (identifier) -> Void in
            var post = Post(imageEndPoint: identifier, userName: UserController.sharedController.currentUser.userName, caption: caption, comments: [], likes: [], identifier: nil)
            post.save()
            completion(success: true, post: post)
        }
    }
 
    static func postFromIdentifier(identifier: String, completion:(posts: Post?) -> Void) {
        FirebaseController.dataAtEndpoint("posts/\(identifier)") { (data) -> Void in
            if let data = data as? [String: AnyObject] {
                let post = Post(json: data, identifier: identifier)
                
                completion(posts: post)
            }else {
                completion(posts: nil)
            }
            
        }
    }
    
    static func postsForUser(user: User, completion:(posts: [Post]?) -> Void) {
        FirebaseController.base.childByAppendingPath("posts").queryOrderedByChild("userName").queryEqualToValue(user.userName).observeSingleEventOfType(.Value, withBlock: { snapshot in
            
            if let postDictionary = snapshot.value as? [String: AnyObject] {
                let posts = postDictionary.flatMap({Post(json: $0.1 as! [String : AnyObject], identifier: $0.0)})
                let order = orderPosts(posts)
                completion(posts: order)
                
            }else {
                completion(posts: nil)
            }
        })
    }
    
    
    static func deletePost(post: Post) {
        post.delete()
    }
    
    static func addCommentWithTextToPost(string: String, post: Post, completion:(success: Bool, post: Post?) -> Void) {
        if let postIdentifier = post.identifier {
            
            var comment = Comment(userName: UserController.sharedController.currentUser.userName, text: string , postIdentifier: postIdentifier)
            comment.save()
            
            PostController.postFromIdentifier(comment.postIdentifier) { (post) -> Void in
                completion(success: true, post: post)
            }
        } else {
            
            var post = post
            post.save()
            var comment = Comment(userName: UserController.sharedController.currentUser.userName, text: string, postIdentifier: post.identifier!)
            comment.save()
            
            PostController.postFromIdentifier(comment.postIdentifier) { (post) -> Void in
                completion(success: true, post: post)
            }
        }
        
        
        
    }
    
    
    
    static func deleteComment(comment: Comment, completion:(success: Bool, post: Post?) -> Void) {
        comment.delete()
        postFromIdentifier(comment.identifier!) { (posts) -> Void in
            completion(success: true, post: posts)
        }
    }
    
    static func addLikeToPost( post: Post, completion:(success: Bool, post: Post?) -> Void) {
        if let postIdentifier = post.identifier {
            var like = Like(userName: UserController.sharedController.currentUser.userName, postIdentifier: postIdentifier, identifier: nil)
            like.save()
            postFromIdentifier(like.identifier!, completion: { (posts) -> Void in
                completion(success: true, post: posts)
            })
        }
        
    }
    
    static func deleteLike(like: Like, completion:(success: Bool, post: Post?) -> Void) {
        like.delete()
        postFromIdentifier(like.identifier!) { (posts) -> Void in
            completion(success: true, post: posts)
        }
        
    }
    
    
    static func orderPosts(post: [Post]) -> [Post] {
        
        return post.sort({$0.0.identifier > $0.1.identifier})
    }
    
    //    static func mockPosts() -> [Post]{
    //        let post1 = Post(imageEndPoint: "-K1l4125TYvKMc7rcp5e", userName: "adamlerois", caption: "", comments: ["comment1", "comment2"], likes: ["like1, like2"], identifier: "1234")
    //        let post2 = Post(imageEndPoint: "-K1l4125TYvKMc7rcp5e", userName: "joseph")
    //        return [post1, post2]
    //    }
    //    
    
    
    
    
    
}