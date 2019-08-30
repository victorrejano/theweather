//
//  PlaceMapper.swift
//  TheWeather
//
//  Created by Victor on 29/08/2019.
//  Copyright © 2019 Victor Rejano. All rights reserved.
//

import Foundation

final class PlaceMapper {
    
    class func map(_ apiResponse: WeatherMapAPIResponse) -> Place {
        
        return Place(
            name: apiResponse.name,
            location: apiResponse.location,
            zipcode: nil)
        
    }
}
