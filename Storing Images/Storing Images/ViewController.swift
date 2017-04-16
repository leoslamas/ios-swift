//
//  ViewController.swift
//  Storing Images
//
//  Created by Leonardo Lamas on 29/03/15.
//  Copyright (c) 2015 Leonardo Lamas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var img: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        /*let url = NSURL(string: "http://www.hdwallpapersimages.com/wp-content/uploads/2014/01/Winter-Tiger-Wild-Cat-Images.jpg")
        
        let urlRequest = NSURLRequest(URL: url!)
        
        NSURLConnection.sendAsynchronousRequest(urlRequest, queue: NSOperationQueue.mainQueue()) { (response, data, error) -> Void in
            if error != nil {
                println("There was an error")
            } else {
                let image = UIImage(data: data)
                
                //self.img.image = image
                
                var documentsDirectory:String?
                var paths:[AnyObject] = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
                
                if paths.count > 0 {
                    documentsDirectory = paths[0] as? String
                    
                    var savePath = documentsDirectory! + "/img.jpg"
                    
                    NSFileManager.defaultManager().createFileAtPath(savePath, contents: data, attributes: nil)
                    
                    self.img.image = UIImage(named: savePath)
                }
            }
        }*/
        
        var documentsDirectory:String?
        var paths:[AnyObject] = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        
        if paths.count > 0 {
            documentsDirectory = paths[0] as? String
            
            var savePath = documentsDirectory! + "/img.jpg"
            
            self.img.image = UIImage(named: savePath)
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

