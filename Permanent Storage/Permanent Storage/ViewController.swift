//
//  ViewController.swift
//  Permanent Storage
//
//  Created by Leonardo Lamas on 24/03/15.
//  Copyright (c) 2015 Leonardo Lamas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        NSUserDefaults.standardUserDefaults().setObject("Bob", forKey: "name")
        
        println(NSUserDefaults.standardUserDefaults().objectForKey("name") as String)
        
        var arr = [1, 2, 3]
        
        NSUserDefaults.standardUserDefaults().setObject(arr, forKey: "array")
        
        println(NSUserDefaults.standardUserDefaults().objectForKey("array") as NSArray)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

