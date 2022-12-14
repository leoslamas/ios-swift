//
//  MasterViewController.swift
//  test2
//
//  Created by Rob Percival on 14/08/2014.
//  Copyright (c) 2014 Appfish. All rights reserved.
//

import UIKit
import CoreData

var activeItem:String = ""


class MasterViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    var detailViewController: DetailViewController? = nil
    var managedObjectContext: NSManagedObjectContext? = nil
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            self.clearsSelectionOnViewWillAppear = false
            self.preferredContentSize = CGSize(width: 320.0, height: 600.0)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Update - changed as to as!
        
        var appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        var context: NSManagedObjectContext = appDel.managedObjectContext!
        
       
        
        let urlPath = "https://www.googleapis.com/blogger/v3/blogs/10861780/posts?key={API_KEY}"
        
        let url = NSURL(string: urlPath)
        
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithURL(url!, completionHandler: {data, response, error -> Void in
            
            if (error != nil) { //change 'error' to '(error != nil)'
                println(error)
            } else {
                
                var request = NSFetchRequest(entityName: "BlogItems")
                
                request.returnsObjectsAsFaults = false
                
                var results = context.executeFetchRequest(request, error: nil)! //append '!' at the end of line in order to convert optional to non-optional
                
                for result in results {
                    
                    // Update - changed as to as!
                    
                    context.deleteObject(result as! NSManagedObject)
                    
                    context.save(nil)
                    
                }
                
                // Update - changed as to as!
                
                let jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as! NSDictionary
                
                
                var items = [[String:String]()]
                
                var item:AnyObject
                
                var authorDictionary:AnyObject
                
                var newBlogItem:NSManagedObject
                
                for var i = 0; i < jsonResult["items"]!.count; i++ {//append '!' after [] in order to convert optional to non-optional
                    
                    items.append([String:String]())
                    
                    // Update - changed as to as!
                    
                    item = jsonResult["items"]![i] as! NSDictionary  //append '!' after [] in order to convert optional to non-optional
                    
                    // Update - changed NSString to String
                    
                    items[i]["content"] = item["content"] as? String
                    
                    // Update - changed NSString to String
                    
                    items[i]["title"] = item["title"] as? String
                    
                    // Update - changed NSString to String
                    
                    items[i]["publishedDate"] = item["published"] as? String
                    
                    // Update - changed as to as!
                    
                    authorDictionary = item["author"] as! NSDictionary
                    
                    // Update - changed NSString to String
                    
                    items[i]["author"] = authorDictionary["displayName"] as? String
                    
                    // Update - changed as to as!
                    
                    newBlogItem = NSEntityDescription.insertNewObjectForEntityForName("BlogItems", inManagedObjectContext: context) as! NSManagedObject
                    
                    newBlogItem.setValue(items[i]["author"], forKey: "author")
                    
                    newBlogItem.setValue(items[i]["title"], forKey: "title")
                    
                    newBlogItem.setValue(items[i]["content"], forKey: "content")
                    
                    newBlogItem.setValue(items[i]["publishedDate"], forKey: "datePublished")
                    
                    context.save(nil)
                    
                }
                
                
                
                request = NSFetchRequest(entityName: "BlogItems")
                
                request.returnsObjectsAsFaults = false
                
                results = context.executeFetchRequest(request, error: nil)!  //append '!' at the end of line in order to convert optional to non-optional

                
                
                
            }
        })
        
        task.resume()
        
        
        
        
        
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = controllers[controllers.count-1].topViewController as? DetailViewController
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func insertNewObject(sender: AnyObject) {
        let context = self.fetchedResultsController.managedObjectContext
        let entity = self.fetchedResultsController.fetchRequest.entity
        
        // Update - changed as to as!
        
        let newManagedObject = NSEntityDescription.insertNewObjectForEntityForName(entity!.name!, inManagedObjectContext: context) as! NSManagedObject
        
        // If appropriate, configure the new managed object.
        // Normally you should use accessor methods, but using KVC here avoids the need to add a custom class to the template.
        newManagedObject.setValue(NSDate(), forKey: "timeStamp")
        
        // Save the context.
        var error: NSError? = nil
        if !context.save(&error) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            //println("Unresolved error \(error), \(error.userInfo)")
            abort()
        }
    }
    
    // MARK: - Segues
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            
            let indexPath = self.tableView.indexPathForSelectedRow()!  //append '!' at the end of line in order to convert optional to non-optional
            
            // Update - changed as to as!
            
            let object = self.fetchedResultsController.objectAtIndexPath(indexPath) as! NSManagedObject
            
            activeItem = object.valueForKey("content")!.description  //append '!' befor description in order to convert optional to non-optional

            // Update - changed as to as!
            
            let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
            
            controller.navigationItem.leftBarButtonItem = self.splitViewController!.displayModeButtonItem()  //append '!' after splitViewController in order to convert optional to non-optional
            controller.navigationItem.leftItemsSupplementBackButton = true
        }
    }
    
    // MARK: - Table View
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.fetchedResultsController.sections!.count  //append '!' after sections in order to convert optional to non-optional
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // Update - changed as to as!
        
        let sectionInfo = self.fetchedResultsController.sections![section] as! NSFetchedResultsSectionInfo  //append '!' after sections in order to convert optional to non-optional
        return sectionInfo.numberOfObjects
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // Update - changed as to as!
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        self.configureCell(cell, atIndexPath: indexPath)
        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let context = self.fetchedResultsController.managedObjectContext
            
            // Update - changed as to as!
            
            context.deleteObject(self.fetchedResultsController.objectAtIndexPath(indexPath) as! NSManagedObject)
            
            var error: NSError? = nil
            if !context.save(&error) {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                //println("Unresolved error \(error), \(error.userInfo)")
                abort()
            }
        }
    }
    
    func configureCell(cell: UITableViewCell, atIndexPath indexPath: NSIndexPath) {
        
        // Update - changed as to as!
        
        let object = self.fetchedResultsController.objectAtIndexPath(indexPath) as! NSManagedObject
        
        // Update - changed textLabel to textLabel?
        
        cell.textLabel?.text = object.valueForKey("title")!.description  //append '!' before description in order to convert optional to non-optional
        cell.detailTextLabel!.text = object.valueForKey("author")!.description  //append '!' before description in order to convert optional to non-optional
    }
    
    // MARK: - Fetched results controller
    
    var fetchedResultsController: NSFetchedResultsController {
        if _fetchedResultsController != nil {
            return _fetchedResultsController!
            }
            
            let fetchRequest = NSFetchRequest()
            // Edit the entity name as appropriate.
            let entity = NSEntityDescription.entityForName("BlogItems", inManagedObjectContext: self.managedObjectContext!)  //append '!' after managedObjectContext in order to convert optional to non-optional
            fetchRequest.entity = entity
            
            // Set the batch size to a suitable number.
            fetchRequest.fetchBatchSize = 20
            
            // Edit the sort key as appropriate.
            let sortDescriptor = NSSortDescriptor(key: "datePublished", ascending: false)
            let sortDescriptors = [sortDescriptor]
            
            fetchRequest.sortDescriptors = [sortDescriptor]
            
            // Edit the section name key path and cache name if appropriate.
            // nil for section name key path means "no sections".
            let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext!, sectionNameKeyPath: nil, cacheName: "Master")  //append '!' after managedObjectContext in order to convert optional to non-optional
            aFetchedResultsController.delegate = self
            _fetchedResultsController = aFetchedResultsController
            
            var error: NSError? = nil
            if !_fetchedResultsController!.performFetch(&error) {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                //println("Unresolved error \(error), \(error.userInfo)")
                abort()
            }
            
            return _fetchedResultsController!
    }
    var _fetchedResultsController: NSFetchedResultsController? = nil
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        self.tableView.beginUpdates()
    }
    
    func controller(controller: NSFetchedResultsController, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
        switch type {
        case .Insert:
            self.tableView.insertSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Fade)
        case .Delete:
            self.tableView.deleteSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Fade)
        default:
            return
        }
    }
    
    /* Changed

    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath) {

    to

    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {

    */
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch type {
        case .Insert:
            
            // Update - changed newIndexPath to newIndexPath!
            
            tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Fade)
            
        case .Delete:
            
            // Update - changed indexPath to indexPath!
            
            tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
            
        case .Update:
            
            // Changed indexPath to indexPath!
            
            self.configureCell(tableView.cellForRowAtIndexPath(indexPath!)!, atIndexPath: indexPath!)  //append '!' after (indexPath) in order to convert optional to non-optional
        case .Move:
            
            // Update - changed indexPath to indexPath!
            
            tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
            
            // Update - changed newIndexPath to newIndexPath!
            
            tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Fade)
        default:
            return
        }
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.tableView.endUpdates()
    }
    
    /*
    // Implementing the above methods to update the table view in response to individual changes may have performance implications if a large number of changes are made simultaneously. If this proves to be an issue, you can instead just implement controllerDidChangeContent: which notifies the delegate that all section and object changes have been processed.
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
    // In the simplest, most efficient, case, reload the table view.
    self.tableView.reloadData()
    }
    */
    
}

