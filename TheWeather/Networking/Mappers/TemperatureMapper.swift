//
//  TemperatureMapper.swift
//  TheWeather
//
//  Created by Victor on 29/08/2019.
//  Copyright © 2019 Victor Rejano. All rights reserved.
//

import Foundation

final class TemperatureMapper {
    
    class func map(_ apiResponse: WeatherMapAPIResponse) -> Temperature? {
        guard let temp = apiResponse.measures else { return nil }
        
        return Temperature(
            max: temp.maxTemp,
            min: temp.minTemp,
            current: temp.currentTemp)
    }
}
