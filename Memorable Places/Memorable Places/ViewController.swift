//
//  ViewController.swift
//  Memorable Places
//
//  Created by Leonardo Lamas on 27/03/15.
//  Copyright (c) 2015 Leonardo Lamas. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {

    var manager: CLLocationManager!
    
    @IBOutlet weak var map: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        
        if activePlace == -1 {
            manager.requestWhenInUseAuthorization()
            manager.startUpdatingLocation()
        }else{
            let latitude = NSString(string: places[activePlace]["lat"]!).doubleValue
            let longitude = NSString(string: places[activePlace]["lon"]!).doubleValue
            var coordinate:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            var latDelta:CLLocationDegrees = 0.01
            var lonDelta:CLLocationDegrees = 0.01
            var span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
            var region:MKCoordinateRegion = MKCoordinateRegionMake(coordinate, span)
            
            self.map.setRegion(region, animated: false)
            
            var annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = places[activePlace]["name"]
            self.map.addAnnotation(annotation)
        }
        
        var uilpgr = UILongPressGestureRecognizer(target: self, action: "action:")
        uilpgr.minimumPressDuration = 1.0
        
        map.addGestureRecognizer(uilpgr)
    }
    
    func action(gestureRecognizer: UIGestureRecognizer){
        if gestureRecognizer.state == UIGestureRecognizerState.Began {
            
            var touchPoint = gestureRecognizer.locationInView(self.map)
            var newCoordinate = self.map.convertPoint(touchPoint, toCoordinateFromView: self.map)
            var location = CLLocation(latitude: newCoordinate.latitude, longitude: newCoordinate.longitude)
            
            CLGeocoder().reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
                
                var title = ""
                
                if(error == nil) {
                    if var p = CLPlacemark(placemark: placemarks?[0] as CLPlacemark!) {
                        var subThoroughfare:String = ""
                        var thoroughfare = ""
                        
                        if p.subThoroughfare != nil {
                            subThoroughfare = p.subThoroughfare
                        }
                        if p.thoroughfare != nil {
                           thoroughfare = p.thoroughfare
                        }
                        
                        title = "\(subThoroughfare) \(thoroughfare)"
                        
                    }
                }
                
                if title == "" {
                    title = "Added \(NSDate())"
                }
                
                places.append(["name":title, "lat":"\(newCoordinate.latitude)",  "lon":"\(newCoordinate.longitude)"])
                
                var annotation = MKPointAnnotation()
                annotation.coordinate = newCoordinate
                annotation.title = title
                self.map.addAnnotation(annotation)
                
            })
            
        }
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        println(locations)
        
        var userLocation : CLLocation = locations[0] as CLLocation
        var latitude = userLocation.coordinate.latitude
        var longitude = userLocation.coordinate.longitude
        var coordinate:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        var latDelta:CLLocationDegrees = 0.01
        var lonDelta:CLLocationDegrees = 0.01
        var span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        var region:MKCoordinateRegion = MKCoordinateRegionMake(coordinate, span)
        self.map.setRegion(region, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

