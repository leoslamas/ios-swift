//
//  ScrollViewController.swift
//  Segues Example
//
//  Created by Leonardo Lamas on 02/04/15.
//  Copyright (c) 2015 Leonardo Lamas. All rights reserved.
//

import UIKit

class ScrollViewController: UIViewController {

    @IBOutlet weak var scrollview: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        
        scrollview.contentSize = CGSizeMake(200, 200)
    }
    
}
