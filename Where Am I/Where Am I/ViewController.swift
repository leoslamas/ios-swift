//
//  ViewController.swift
//  Where Am I
//
//  Created by Leonardo Lamas on 26/03/15.
//  Copyright (c) 2015 Leonardo Lamas. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    var manager:CLLocationManager!
    
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var courseLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var altitudeLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        println(locations)
        
        var userLocation: CLLocation = locations[0] as CLLocation
        latitudeLabel.text = "\(userLocation.coordinate.latitude)"
        longitudeLabel.text = "\(userLocation.coordinate.longitude)"
        courseLabel.text = "\(userLocation.course)"
        speedLabel.text = "\(userLocation.speed)"
        altitudeLabel.text = "\(userLocation.altitude)"
        
        CLGeocoder().reverseGeocodeLocation(userLocation, completionHandler: {
            (placemarks, error) -> Void in
            if error != nil {
                println(error)
            }else{
                if let p = CLPlacemark(placemark: placemarks?[0] as CLPlacemark!) {
                    println(p)
                    self.addressLabel.text = "\(p.subAdministrativeArea) \(p.postalCode) \(p.country)"
                }
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

