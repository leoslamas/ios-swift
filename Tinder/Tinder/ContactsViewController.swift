//
//  ContactsViewController.swift
//  Tinder
//
//  Created by Rob Percival on 28/10/2014.
//  Copyright (c) 2014 Appfish. All rights reserved.
//

import UIKit
import MessageUI

class ContactsViewController: UITableViewController, MFMailComposeViewControllerDelegate {

    var emails = [String]()
    var images = [NSData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        var query = PFUser.query()
        query.whereKey("accepted", equalTo: PFUser.currentUser().username)
        
        // Update - replaced as with as!
        
        query.whereKey("username", containedIn: PFUser.currentUser()["accepted"] as! [AnyObject])
        query.findObjectsInBackgroundWithBlock { (results, error) -> Void in
            
            if results != nil {
                
                println(results)
                
                for result in results {
                    
                    // Update - replaced as with as!
                    
                    self.emails.append(result["email"] as! String)
                    
                    // Update - replaced as with as!
                    
                    self.images.append(result["image"] as! NSData)
                    
                    
                }
                self.tableView.reloadData()
                
            }
        
            
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return emails.count
        
    }

   
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // Update - replaced as with as!
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell
        
        cell.textLabel?.text = emails[indexPath.row]
        
            cell.imageView?.image = UIImage(data: images[indexPath.row])
        
       
        
        // Configure the cell...

        return cell
    }
  
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
       
        var url = NSURL(string: "mailto:dts@apple.com")
        
         UIApplication.sharedApplication().openURL(url!)
        
    }
   
}
