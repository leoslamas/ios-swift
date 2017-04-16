//
//  ViewController.swift
//  Instagram
//
//  Created by Rob Percival on 01/09/2014.
//  Copyright (c) 2014 Appfish. All rights reserved.
//

import UIKit



class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    @IBOutlet var pickedImage: UIImageView!
    
    
    // Update - ! removed
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        println("Image selected")
        self.dismissViewControllerAnimated(true, completion: nil)
        
        pickedImage.image = image
        
    }
    
    @IBAction func pickImage(sender: AnyObject) {
        
        var image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.PhotoLibrary //.Camera
        image.allowsEditing = false
        
        self.presentViewController(image, animated: true, completion: nil)
        
    }
    

    @IBAction func pause(sender: AnyObject) {
        
        activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        // UIApplication.sharedApplication().beginIgnoringInteractionEvents()
    }
    
    
    
    @IBAction func restore(sender: AnyObject) {
        activityIndicator.stopAnimating()
        // UIApplication.sharedApplication().endIgnoringInteractionEvents()
    }
    
    
    @IBAction func createAlert(sender: AnyObject) {
        
        var alert = UIAlertController(title: "Hey There!", message: "Are you sure?", preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { action in
        
            self.dismissViewControllerAnimated(true, completion: nil)
            
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        /*
        
         Parse.setApplicationId("9hlPLR99kx6VPLz48wpsGRsKdaRR6offO3syBnMk", clientKey: "eFMDmjBJ9YPEnQ1AGoOQOwVafYpTLNNSLcRy4WIg")
        
        
        
        var score = PFObject(className: "score")
        score.setObject("Rob", forKey: "name")
        score.setObject(95, forKey: "number")
        score.saveInBackgroundWithBlock {
            (success: Bool!, error: NSError!) -> Void in
            
            if success == true {
                
                println("Score created with ID: \(score.objectId)")
                
            } else {
                
                println(error)
                
            }
            
        
        }


        
        var query = PFQuery(className: "score")
        query.getObjectInBackgroundWithId("8zcsg7sxZI") {
            (score: PFObject!, error: NSError!) -> Void in
            
            if error == nil {
                
                // println(score.objectForKey("name") as NSString)
                
                score["name"] = "Robert"
                score["score"] = 137
                
                score.saveInBackground()
                
                
                
            } else {
                
                println(error)
                
            }
            
            
        }

    */
        
        
        

        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

