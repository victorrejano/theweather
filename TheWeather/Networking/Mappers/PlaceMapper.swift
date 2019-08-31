//
//  PlaceMapper.swift
//  TheWeather
//
//  Created by Victor on 29/08/2019.
//  Copyright © 2019 Victor Rejano. All rights reserved.
//

import Foundation
import GooglePlaces

final class PlaceMapper {
    
    class func map(_ apiResponse: WeatherMapAPIResponse) -> Place {
        
        return Place(
            name: apiResponse.name,
            location: apiResponse.location
        )
        
    }
    
    class func map(_ googlePlace: GMSPlace) -> Place {
        
        return Place(name: googlePlace.name,
                     location: Location(lat: googlePlace.coordinate.latitude,
                                        lon: googlePlace.coordinate.longitude)
        )
    }
}
