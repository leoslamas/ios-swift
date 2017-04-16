//
//  ViewController.swift
//  Animations
//
//  Created by Leonardo Lamas on 25/03/15.
//  Copyright (c) 2015 Leonardo Lamas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var counter = 1
    var frame = CGRect()
    var timer = NSTimer()
    var isAnimating = true
    
    @IBOutlet weak var alienImage: UIImageView!
    
    @IBAction func updateImage(sender: AnyObject) {
        if isAnimating == true {
            timer.invalidate()
            isAnimating = false
        }else{
            timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("doAnimation"), userInfo: nil, repeats: true)
            isAnimating = true
        }
    }
    
    /*override func viewDidLayoutSubviews() {
        frame = alienImage.frame
        alienImage.frame = CGRectMake(0, 0, 0, 0)
        alienImage.alpha = 0
        alienImage.center = CGPointMake(alienImage.center.x - 400, alienImage.center.y)
    }
    
    override func viewDidAppear(animated: Bool) {
        UIView.animateWithDuration(1, animations: {() -> Void in
            self.alienImage.frame = self.frame
            self.alienImage.alpha = 1
            //self.alienImage.center = CGPointMake(self.alienImage.center.x + 400, self.alienImage.center.y)
        })
    }*/
    
    func doAnimation(){
        if counter == 5 {
            counter = 1
        }else{
            counter++
        }
        alienImage.image = UIImage(named: "frame\(counter).png")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("doAnimation"), userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

