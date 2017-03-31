//
//  ViewController.swift
//  Is it raining
//
//  Created by Jimmy Klein on 3/31/17.
//  Copyright © 2017 Jimmy Klein. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        switch CLLocationManager.authorizationStatus() {
//        case CLAuthorizationStatus.authorizedAlways:
//            
//        }
        
    }

    @IBOutlet weak var rainingLabel: UILabel!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func testButton(_ sender: Any) {
        print("tesT")
        let weatherAPI = WeatherAPI()
        weatherAPI.getWeather()
    }

}

