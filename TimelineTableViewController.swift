//
//  TimelineTableViewController.swift
//  Timeline
//
//  Created by youcef bouhafna on 2/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class TimelineTableViewController: UITableViewController {
    var posts:[Post] = []
    
    @IBAction func userRefreshedTable() {
        
        loadTimeLineForUser(UserController.sharedController.currentUser)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let currentUser = UserController.sharedController.currentUser {
            loadTimeLineForUser(currentUser)
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if UserController.sharedController.currentUser != nil {
            self.tableView.reloadData()
        } else {
            self.tabBarController?.performSegueWithIdentifier("noCurrentUser", sender: nil)
        }
    }
    func loadTimeLineForUser(user: User) {
        PostController.fetchTimeLineForUser(user) { ( posts) -> Void in
            
            self.posts = posts
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.tableView.reloadData()
            })
            
            self.refreshControl?.endRefreshing()
        }
        
        
        
        
    }
    


override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
}

// MARK: - Table view data source


override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return posts.count
}


override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("postCell", forIndexPath: indexPath) as! PostTableViewCell
    let post = posts[indexPath.row]
    cell.updateWithPost(post)
    return cell
}


/*
// Override to support conditional editing of the table view.
override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
// Return false if you do not want the specified item to be editable.
return true
}
*/

/*
// Override to support editing the table view.
override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
if editingStyle == .Delete {
// Delete the row from the data source
tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
} else if editingStyle == .Insert {
// Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
}
}
*/

/*
// Override to support rearranging the table view.
override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

}
*/

/*
// Override to support conditional rearranging of the table view.
override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
// Return false if you do not want the item to be re-orderable.
return true
}
*/

override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "fromTimelinetoPostDetail" {
        if let cell = sender as? UITableViewCell, let indexPath = tableView.indexPathForCell(cell) {
            
            let post = posts[indexPath.row]
            
            let destinationViewController = segue.destinationViewController as? PostDetailTableViewController
            
            destinationViewController?.post = post
        }
    }
}


}
