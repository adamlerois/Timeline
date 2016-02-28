//
//  PostTableViewCell.swift
//  Timeline
//
//  Created by youcef bouhafna on 2/28/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func updateWithPost(post: Post) {
        self.commentsLabel.text = "Comments"
        self.likesLabel.text = "Likes"
        
        
        ImageController.imageForIdentifier(post.imageEndPoint) { (image) -> Void in
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.postImageView.image = image
        })
            
            
            
            }
            }
        }
        
        
        

    
    
    
    
    
    
    
    


