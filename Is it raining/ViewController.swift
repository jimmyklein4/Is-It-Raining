//
//  ViewController.swift
//  Is it raining
//
//  Created by Jimmy Klein on 3/31/17.
//  Copyright © 2017 Jimmy Klein. All rights reserved.
//

import UIKit
import CoreLocation


class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet var rainingLabel: UILabel!
    
    private let weatherAPI = WeatherAPI()
    override func viewDidLoad() {
        super.viewDidLoad()
        let locationManager = CLLocationManager()
        if(CLLocationManager.locationServicesEnabled()){
            //locationManager.requestAlwaysAuthorization()
            locationManager.delegate = self
            locationManager.requestWhenInUseAuthorization()
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestLocation()
            locationManager.startUpdatingLocation()
        }
        
        weatherAPI.delegate = self
        weatherAPI.getWeather(location: locationManager.location)
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        weatherAPI.getWeather(location: manager.location)
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func updateRaining(result: String){
        if(result == "Rain"){
            print(NSDate.timeIntervalSinceReferenceDate)
            DispatchQueue.main.async{
                self.rainingLabel.text = "Yes it is raining"
            }
        } else {
            print(NSDate.timeIntervalSinceReferenceDate)
            DispatchQueue.main.async{
                self.rainingLabel.text = "No it is \(result)"
            }
        }
    }
    
}

extension ViewController: WeatherDataDelegate {
    func didReceiveWeatherUpdate(data: String) {
        updateRaining(result: data)
    }
}
