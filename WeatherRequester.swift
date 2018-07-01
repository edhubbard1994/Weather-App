//
//  WeatherRequester.swift
//  Weather App
//
//  Created by Edward Hubbard on 4/1/18.
//  Copyright © 2018 Edward Hubbard. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherRequester: NSObject {
    struct JSONInfo: Decodable{
        let latitude:Double?
        let longitude:Double?
        let timezone:String?
        let currently: currently?
        let offset:Int?
        }
    struct currently: Decodable{
        let time:Int?
        let summary:String?
        let icon: String?
        let precipIntensity:Int?
        let precipProbability:Int?
        let temperature:Float?
        let apparentTempurature:Float?
        let dewPoint:Float?
        let humidity:Float?
        let pressure:Float?
        let windSpeed:Float?
        let windGust:Float?
        let windBearing:Int?
        let cloudCover:Float?
        let uvIndex:Int?
        let ozone:Float?
        
    }
    let coordinates: CLLocationCoordinate2D
    init(coordinates: CLLocationCoordinate2D) {
        self.coordinates = coordinates
    }
    func getWeather(callback:@escaping (WeatherRequester.JSONInfo)->Void){
        let url = "https://api.darksky.net/forecast/a9742497c456c39cbecf31276183b72b/\(coordinates.latitude),\(coordinates.longitude)?exclude=daily,hourly,flags"
        let seesion = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler:{ (data,response,error) in
            if error != nil{
                
            }
            guard let data = data else {return}
            let decoder = JSONDecoder()
            let JSON = try? decoder.decode(JSONInfo.self, from: data)
            if JSON != nil{
              callback(JSON!)
            }
            
        }).resume()
        
       
    }
}
