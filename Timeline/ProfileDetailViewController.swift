//
//  ProfileDetailViewController.swift
//  Timeline
//
//  Created by youcef bouhafna on 2/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit
import SafariServices

class ProfileDetailViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, ProfileHeaderCollectionReusableViewDelegate {
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var editBarButton: UIBarButtonItem!
    var user: User?
    var userPosts: [Post] = []
    func updateBasedOnUser() {
        guard let user = user else {
            return
        }
        title = user.userName
        PostController.postsForUser(user) { ( posts) -> Void in
            if let posts = posts {
                self.userPosts = posts
                
            }else {
                self.userPosts = []
            }
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                // now you have to add collectionview  @IBoutlet  otherwise its gonna throw an error /////////\\\\\\\\
                self.collectionView.reloadData()
            })
        }
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.user == nil {
            user = UserController.sharedController.currentUser
            editBarButton.enabled = true
        }
        print(user)
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK:- UICollectionViewDataSource
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userPosts.count
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("collectionViewCell", forIndexPath: indexPath) as! ImageCollectionViewCell
        let post = userPosts[indexPath.row]
        cell.updateWithImageIdentifier(post.imageEndPoint)
        return cell
        
        
    }
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: "HeaderViewIdentifier", forIndexPath: indexPath) as! ProfileHeaderCollectionReusableView
        headerView.updateWithUser(user!)
        headerView.delegate = self
        return headerView
        
    }
    
    
    // Implementing the safari viewController
    
    func userTappedURLButton() {
        let safari = SFSafariViewController(URL: NSURL(string: (user?.url)!)!)
        self.presentViewController(safari, animated: true, completion: nil)
    }
    
    func userTappedFollowActionButton(){
        guard let user = user else {return}
        if user == UserController.sharedController.currentUser {
            
            UserController.logoutCurrentUser()
            tabBarController?.selectedViewController = tabBarController?.viewControllers![0]
            
            
        } else {
            if user == UserController.sharedController.currentUser {
                UserController.userFollowUser(user, checkingUser: user, completion: { (follows) -> Void in
                    if follows {
                        
                        UserController.unfollowUser(user, completion: { (success) -> Void in
                            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                self.updateBasedOnUser()
                            })
                        })
                    }
                    else {
                        UserController.followUser(user, completion: { (success) -> Void in
                            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                self.updateBasedOnUser()
                            })
                        })
                        
                    }
                })
            }
        }
    }
    
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toEditProfile" {
            if let destinationViewController = segue.destinationViewController as? LoginSignupViewController {
                _ = destinationViewController.view
                destinationViewController.updateWithUser(user!)
            } else {
                if segue.identifier == "toPostDetailView" {
                    if let cell = sender as? UICollectionViewCell, let indexPath = collectionView.indexPathForCell(cell) {
                        let post = userPosts[indexPath.item]
                        let destinationViewController = segue.destinationViewController as? PostDetailTableViewController
                        destinationViewController?.post = post
                    }
                    
                }
                
            }
        }
        
        
        
        
        
        
        
    }
}