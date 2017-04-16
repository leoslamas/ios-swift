//
//  ViewController.swift
//  Audio
//
//  Created by Leonardo Lamas on 27/03/15.
//  Copyright (c) 2015 Leonardo Lamas. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {

    var player : AVAudioPlayer = AVAudioPlayer()
    
    @IBOutlet weak var volume: UISlider!
    
    @IBAction func play(sender: AnyObject) {
        player.play()
    }
    
    @IBAction func pause(sender: AnyObject) {
        player.pause()
    }
    
    @IBAction func stop(sender: AnyObject) {
        player.stop()
        player.currentTime = 0
    }
    
    @IBAction func volumeChanged(sender: AnyObject) {
        player.volume = volume.value
    }
    
    func audioPlayerDecodeErrorDidOccur(player: AVAudioPlayer!, error: NSError!) {
        println(error)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var audioPath = NSBundle.mainBundle().pathForResource("theme", ofType: "mp3")!
        
        var error : NSError? = nil
        
        player = AVAudioPlayer(contentsOfURL: NSURL(string: audioPath), error: &error)
        
        player.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

