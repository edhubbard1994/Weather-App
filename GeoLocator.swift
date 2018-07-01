//
//  GeoLocator.swift
//  Weather App
//
//  Created by Edward Hubbard on 3/28/18.
//  Copyright © 2018 Edward Hubbard. All rights reserved.
//

import UIKit
import CoreLocation

class GeoLocator: NSObject {
    
    var locationString : String
    
     init(locationString: String){
        self.locationString = locationString
        super.init()
      
    }
    
    func getCoordinate (addressString: String, completionHandler: @escaping(Array<CLPlacemark>?,NSError?)->Void){
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(addressString, completionHandler: { (placemarks,error) in
            if error == nil {
                var placesArray:Array<CLPlacemark> = Array()
                for placemark in placemarks!{
                    placesArray.append(placemark)
                }
                completionHandler(placesArray, nil)
                return
            }
            completionHandler(nil,error! as NSError)
        })
    }
    

}


