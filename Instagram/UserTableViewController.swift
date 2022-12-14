//
//  UserTableViewController.swift
//  Instagram
//
//  Created by Rob Percival on 05/09/2014.
//  Copyright (c) 2014 Appfish. All rights reserved.
//

import UIKit

class UserTableViewController: UITableViewController {
    
    var users = [""]
    var following = [Bool]()
   
    var refresher: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        println(PFUser.currentUser())
        
        updateUsers()
        
        refresher = UIRefreshControl()
        refresher.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refresher.addTarget(self, action: "refresh", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refresher)
        
        
    }
    
    func updateUsers() {
        
        var query = PFUser.query()
        
        query.findObjectsInBackgroundWithBlock({ (objects: [AnyObject]!, error: NSError!) -> Void in
            
            self.users.removeAll(keepCapacity: true)
            
            for object in objects {
                
                // Update - replaced as with as!
                
                var user:PFUser = object as! PFUser
                
                var isFollowing:Bool
                
                if user.username != PFUser.currentUser().username {
                    
                    self.users.append(user.username)
                    
                    isFollowing = false
                    
                    var query = PFQuery(className:"followers")
                    query.whereKey("follower", equalTo:PFUser.currentUser().username)
                    query.whereKey("following", equalTo:user.username)
                    query.findObjectsInBackgroundWithBlock {
                        (objects: [AnyObject]!, error: NSError!) -> Void in
                        if error == nil {
                            
                            for object in objects {
                                
                                isFollowing = true
                                
                            }
                            
                            self.following.append(isFollowing)
                            
                            self.tableView.reloadData()
                            
                            
                        } else {
                            // Log details of the failure
                            println(error)
                        }
                        
                        self.refresher.endRefreshing()
                    }
                    
                }
                
                
            }
            
            
            
        })

        
        
    }
    
    func refresh() {
        
        println("refreshed")
        
        updateUsers()
        
    }
        
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        println(following)
        return users.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // Update - replaced as with as!
        
        var cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell") as! UITableViewCell
        
        if following.count > indexPath.row {
        
            if following[indexPath.row] == true {
            
                cell.accessoryType = UITableViewCellAccessoryType.Checkmark
            
            }
            
        }
        
        cell.textLabel?.text = users[indexPath.row]
        
        return cell
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        var cell:UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
        
        if cell.accessoryType == UITableViewCellAccessoryType.Checkmark {
            
            cell.accessoryType = UITableViewCellAccessoryType.None
            
            var query = PFQuery(className:"followers")
            query.whereKey("follower", equalTo:PFUser.currentUser().username)
            query.whereKey("following", equalTo:cell.textLabel?.text)
            query.findObjectsInBackgroundWithBlock {
                (objects: [AnyObject]!, error: NSError!) -> Void in
                if error == nil {
                    
                    for object in objects {
                        
                        object.deleteInBackground()
                        
                    }
                } else {
                    // Log details of the failure
                    println(error)
                }
            }
            
        } else {
        
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
            
            var following = PFObject(className: "followers")
            following["following"] = cell.textLabel?.text
            following["follower"] = PFUser.currentUser().username
            
            following.saveInBackground()
            
        }
        
    }
    
    

}
