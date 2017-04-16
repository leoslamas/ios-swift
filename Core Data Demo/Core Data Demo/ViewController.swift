//
//  ViewController.swift
//  Core Data Demo
//
//  Created by Leonardo Lamas on 28/03/15.
//  Copyright (c) 2015 Leonardo Lamas. All rights reserved.
//
import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var appDel:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        var context:NSManagedObjectContext = appDel.managedObjectContext!
        
        //var newUser = NSEntityDescription.insertNewObjectForEntityForName("Users", inManagedObjectContext: context) as NSManagedObject
        //newUser.setValue("Job", forKey: "username")
        //newUser.setValue("pass", forKey: "password")
        //context.save(nil)
        
        var request = NSFetchRequest(entityName: "Users")
        request.returnsObjectsAsFaults = false
        
        request.predicate = NSPredicate(format: "username = %@", "Job")
        
        var results = context.executeFetchRequest(request, error: nil)
        
        println(results)
        
        if results?.count > 0 {
            for result in results! {
                if let user = result.valueForKey("username") as? String {
                    if user == "Job" {
                        //println(user)
                        //context.deleteObject(result as NSManagedObject)
                        
                        //result.setValue("pass6", forKey: "password")
                    }
                }
                context.save(nil)
            }
        }else{
            println("no results")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

