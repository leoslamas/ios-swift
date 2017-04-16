//
//  ViewController.swift
//  Whats The Weather
//
//  Created by Leonardo Lamas on 24/03/15.
//  Copyright (c) 2015 Leonardo Lamas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var userCity: UITextField!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBAction func findWeather(sender: AnyObject) {
        var userCityFinal = self.userCity.text.stringByReplacingOccurrencesOfString(" ", withString: "-")
        
        var url = NSURL(string: "http://weather-forecast.com/locations/\(userCityFinal)/forecasts/latest")
        
        if url != nil {
            let task = NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler: {(data, response, error) in
                var urlError = false
                var weather = ""
                if error == nil {
                    var urlContent = NSString(data: data, encoding: NSUTF8StringEncoding) as NSString!
                    
                    var urlContentArray = urlContent.componentsSeparatedByString("<span class=\"phrase\">")
                    
                    if urlContentArray.count > 0 {
                        
                        var weatherArray = urlContentArray[1].componentsSeparatedByString("</span>")
                        
                        weather = weatherArray[0] as String
                        weather = weather.stringByReplacingOccurrencesOfString("&deg", withString: "º")
                        
                    }else{
                        urlError = true
                    }
                }else{
                    urlError = true
                }
                
                dispatch_async(dispatch_get_main_queue()) {
                    
                    if urlError == true {
                        self.showError()
                    }else{
                        self.resultLabel.text = weather
                    }
                }
            })
            
            task.resume()
            
        }else{
            showError()
        }

    }
    
    func showError(){
        resultLabel.text = "Was not able to find weather for \(userCity.text). Please try again."
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

