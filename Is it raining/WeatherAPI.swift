//
//  WeatherAPI.swift
//  Is it raining
//
//  Created by Jimmy Klein on 3/31/17.
//  Copyright © 2017 Jimmy Klein. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherDataDelegate: class {
    func didReceiveWeatherUpdate(data: String)
}


class WeatherAPI: NSObject {
    weak var delegate: WeatherDataDelegate?
    func getWeather(location: CLLocation?) {
        var keys: NSDictionary?
        var apiKey: String?
        if let path = Bundle.main.path(forResource: "Keys", ofType: "plist") {
            keys = NSDictionary(contentsOfFile: path)
        }
        if let dict = keys {
            apiKey = dict["apiKey"] as? String
            
        }
        
        let baseURL = "http://api.openweathermap.org/data/2.5/weather?zip="

        CLGeocoder().reverseGeocodeLocation(location!, completionHandler: {(placemarks, error) -> Void in
            
            if error != nil {
                print("Reverse geocoder failed with error" + error!.localizedDescription)
                return
            }
        
            if placemarks!.count > 0 {
                let pm = placemarks![0]
                let postalCode: String = pm.postalCode! //prints zip code
                let urlString = baseURL + postalCode + ",us&appid=" + apiKey!
                let url = URL(string: urlString)
                let task = URLSession.shared.dataTask(with: url!, completionHandler: { data, response, error  in
                    do{
                        let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String: AnyObject]
                        guard let weather = json["weather"] else {
                            print("error with json")
                            return
                        }
                        guard let currentWeather = weather[0] as? [String: Any] else {
                            print("error eith line 49")
                            return
                        }
                        print(NSDate.timeIntervalSinceReferenceDate)
                        self.delegate?.didReceiveWeatherUpdate(data: currentWeather["main"] as! String)
                    } catch let error as NSError {
                        print(error)
                    }
                })
                task.resume()
            }
            else {
                print("Problem with the data received from geocoder")
            }
        })
    }
}
