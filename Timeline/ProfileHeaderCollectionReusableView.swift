//
//  ProfileHeaderCollectionReusableView.swift
//  Timeline
//
//  Created by youcef bouhafna on 2/26/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class ProfileHeaderCollectionReusableView: UICollectionReusableView {
    
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var urlButton: UIButton!
    @IBOutlet weak var followUserButton: UIButton!
    var delegate: ProfileHeaderCollectionReusableViewDelegate?
    @IBAction func urlButtonTapped(sender: AnyObject){
       
        // calling the protocol function that we created on the bottom
        delegate?.userTappedURLButton()
    }
    
    @IBAction func followActionButtonTapped(sender: AnyObject) {
        
    }
    func updateWithUser(user: User) {
        if let bio = user.bio {
            bioLabel.text = bio
        } else {
            bioLabel.hidden = true
        }
        
        if let url = user.url {
            urlButton.setTitle(url, forState: .Normal)
        } else {
            urlButton.hidden = true
        }
        
        if user == UserController.sharedController.currentUser {
            followUserButton.hidden = true
        } else {
            followUserButton.hidden = false
        }
        UserController.userFollowUser(UserController.sharedController.currentUser, checkingUser: user) { (follows) -> Void in
            if  follows {
                self.followUserButton.setTitle("Unfollow", forState: .Normal)
            } else {
                self.followUserButton.setTitle("follow", forState: .Normal)
            }
        }
        
    }
    
}
    protocol ProfileHeaderCollectionReusableViewDelegate {
    
    func userTappedFollowActionButton()
        func userTappedURLButton()
    
}




