//
//  UserSearchTableViewController.swift
//  Timeline
//
//  Created by youcef bouhafna on 2/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class UserSearchTableViewController: UITableViewController, UISearchResultsUpdating {
    var usersDataSource: [User] = []
    var searchController: UISearchController!

    
    enum ViewMode: Int {
        case Friends = 0
        case All = 1
        func users(completion: (users: [User]?) -> Void) {
            switch self {
            case .Friends:
                UserController.followedByUser(UserController.sharedController.currentUser) { (followers) -> Void in
                completion(users: followers)
                }
                
                
            case .All:
                UserController.fetchAllUsers() { (users) -> Void in
                    completion(users: users)
                }
                
            }
        }
    }
    
    
    
    
    
    // properties//////////\\\\\\\\\
    @IBOutlet weak var modeSegmentedControl: UISegmentedControl!
    var mode: ViewMode {
        return ViewMode(rawValue: modeSegmentedControl.selectedSegmentIndex)!
        
    }
    // functions/////////\\\\\\\\\\\
    
    
    @IBAction func selectedIndexChanged(sender: AnyObject) {
    }
    
    
    func updateViewBasedOnMode() {
        mode.users { (users) -> Void in
            if let users = users {
            self.usersDataSource = users
            
            } else {
            self.usersDataSource = []
            }
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViewBasedOnMode()
    }
    
    
    ///////
    
    func setUpSearchController() {
        let resultsController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("searchResultScene")
        searchController = UISearchController(searchResultsController: resultsController)
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search Users..."
        searchController.hidesNavigationBarDuringPresentation = true
        tableView.tableHeaderView = searchController.searchBar
        
        
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchTerm = searchController.searchBar.text ?? "".lowercaseString
        let resultsViewController = searchController.searchResultsController as! UserSearchResultsTableViewController
            resultsViewController.userResultsDataSource = usersDataSource.filter({$0.userName.lowercaseString.containsString(searchTerm)})
            resultsViewController.tableView.reloadData()
        }
    

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersDataSource.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("fromCell", forIndexPath: indexPath)
        let user = usersDataSource[indexPath.row]
        cell.textLabel?.text = user.userName
        return cell
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "toProfile" {
            if let cell = sender as? UITableViewCell {
            let destinationController = segue.destinationViewController as! ProfileDetailViewController
                if  let indexPath = tableView.indexPathForCell(cell) {
                let user = usersDataSource[indexPath.row]
                    destinationController.user = user
                
                }else if let indexPath = (searchController.searchResultsController as? UserSearchResultsTableViewController)?.tableView.indexPathForCell(cell) {
                    
                    let user = (searchController.searchResultsController as! UserSearchResultsTableViewController).userResultsDataSource[indexPath.row]
                    
                    let destinationViewController = segue.destinationViewController as? ProfileDetailViewController
                    destinationViewController?.user = user
 
                    
                    
                }
        }
        
        
        
        
        
        
        
        
        
        
    }
    

}
}