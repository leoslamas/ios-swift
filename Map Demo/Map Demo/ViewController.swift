//
//  ViewController.swift
//  Map Demo
//
//  Created by Leonardo Lamas on 26/03/15.
//  Copyright (c) 2015 Leonardo Lamas. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var map: MKMapView!
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        var latitude: CLLocationDegrees = 43.095181
        var longitude: CLLocationDegrees = -79.006424
        var latDelta: CLLocationDegrees = 0.05
        var lonDelta: CLLocationDegrees = 0.05
        var span: MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        var location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        var region: MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        map.setRegion(region, animated: false)
        
        var annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "Niagara Falls"
        annotation.subtitle = "One day I'll go here..."
        
        map.addAnnotation(annotation)
        
        
        
        var uilpgr = UILongPressGestureRecognizer(target: self, action: "action:")
        uilpgr.minimumPressDuration = 2
        
        map.addGestureRecognizer(uilpgr)
    }
    
    func action(gesturerecognizer: UIGestureRecognizer) {
        println("Gesture recognized")
        
        var touchPoint = gesturerecognizer.locationInView(self.map)
        var newCoordinate: CLLocationCoordinate2D = map.convertPoint(touchPoint, toCoordinateFromView: self.map)
        var annotation = MKPointAnnotation()
        annotation.coordinate = newCoordinate
        annotation.title = "New Place"
        annotation.subtitle = "One day I'll go here..."
        map.addAnnotation(annotation)
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        println(locations)
        
        var userLocation: CLLocation = locations[0] as CLLocation
        var latitude = userLocation.coordinate.latitude
        var longitude = userLocation.coordinate.longitude
        var latDelta: CLLocationDegrees = 0.005
        var lonDelta: CLLocationDegrees = 0.005
        var span: MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        var location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        var region: MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        self.map.setRegion(region, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

