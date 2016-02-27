//
//  ProfileDetailViewController.swift
//  Timeline
//
//  Created by youcef bouhafna on 2/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class ProfileDetailViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
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
                // now you have to add collectionview  @IBoutlet  otherwise its gonna throw an erro /////////\\\\\\\\
             self.collectionView.reloadData() 
            })
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        print(user)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
