//
//  ViewController.swift
//  ScrollView Demo
//
//  Created by Leonardo Lamas on 02/04/15.
//  Copyright (c) 2015 Leonardo Lamas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scroll: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.scroll.contentSize = CGSizeMake(view.bounds.width, view.bounds.height+500)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

