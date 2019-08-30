//
//  HumidityMapper.swift
//  TheWeather
//
//  Created by Victor on 30/08/2019.
//  Copyright © 2019 Victor Rejano. All rights reserved.
//

import Foundation

final class HumidityMapper {
    
    class func map(_ apiResponse: WeatherMapAPIResponse) -> Humidity? {
        
        guard let humidity = apiResponse.measures?.humidity else { return nil }
        return Humidity(percentage: humidity)
        
    }
}
