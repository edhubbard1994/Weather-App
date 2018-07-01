//
//  WeatherDescription.swift
//  Weather App
//
//  Created by Edward Hubbard on 4/10/18.
//  Copyright © 2018 Edward Hubbard. All rights reserved.
//

import UIKit

class WeatherDescription: NSObject {
    let pictureDictionary = ["clear-day":#imageLiteral(resourceName: "clear-day"),
                             "clear-night":#imageLiteral(resourceName: "clear-night"),
                             "rain":#imageLiteral(resourceName: "rain"),
                             "sleet":#imageLiteral(resourceName: "sleet"),
                             "snow":#imageLiteral(resourceName: "snow"),
                             "wind":#imageLiteral(resourceName: "wind"),
                             "fog":#imageLiteral(resourceName: "fog"),
                             "cloudy":#imageLiteral(resourceName: "cloudy"),
                             "partly-cloudy-day":#imageLiteral(resourceName: "clear-day"),
                             "partly-cloudy-night":#imageLiteral(resourceName: "clear-night")]
    var backgroundImage: UIImage?
    init(description: String,temp: Float) {
        self.backgroundImage = pictureDictionary[description]!
        super.init()
        checkTemp(temp: temp)
    }
    func checkTemp(temp: Float){
        if temp <= 32.0{
            self.backgroundImage = #imageLiteral(resourceName: "cold")
        }
        else if temp >= 85.0{
            self.backgroundImage = #imageLiteral(resourceName: "hot")
        }
            }
    func conditionImage(size: CGSize) -> UIImage? {
        return UIImage.scaleImageToSize(img: self.backgroundImage!, size: size)
    }
}
