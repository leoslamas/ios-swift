//
//  ViewController.swift
//  Downloading Web Content
//
//  Created by Leonardo Lamas on 24/03/15.
//  Copyright (c) 2015 Leonardo Lamas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let url = NSURL(string: "http://www.stackoverflow.com")
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!){
            (data, response, error) in
            if error == nil {
                var urlContent = NSString(data: data, encoding: NSUTF8StringEncoding)
                
                self.webView.loadHTMLString(urlContent!, baseURL: url!)
            }
        }
        
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

