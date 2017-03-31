//
//  WeatherAPI.swift
//  Is it raining
//
//  Created by Jimmy Klein on 3/31/17.
//  Copyright © 2017 Jimmy Klein. All rights reserved.
//

import Foundation

class WeatherAPI: NSObject {
    

    func getWeather() {
        let baseURL = URL(string: "http://api.openweathermap.org/data/2.5/weather?zip=19040,us&appid=65cf8412db97ec5591b921942ba014af")
        //let request: NSMutableURLRequest = NSMutableURLRequest()
        //request.url = URL(string: baseURL)
        //request.httpMethod = "GET"
        print(baseURL?.absoluteString)
        let task = URLSession.shared.dataTask(with: baseURL!) {(data, response, error) in
            print(String(data: data!, encoding: .utf8)!)
        }
        task.resume()
    }
}
