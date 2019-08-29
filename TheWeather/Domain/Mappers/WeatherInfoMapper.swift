//
//  WeatherInfoMapper.swift
//  TheWeather
//
//  Created by Victor on 29/08/2019.
//  Copyright © 2019 Victor Rejano. All rights reserved.
//

import Foundation

final class WeatherInfoMapper {
    
    class func map(_ apiResponse: WeatherMapAPIResponse) -> WeatherInfo {
        return WeatherInfo(
            temperature: TemperatureMapper.map(apiResponse),
            humidity: apiResponse.measures?.humidity,
            rain: apiResponse.rain,
            wind: apiResponse.wind,
            lastUpdate: apiResponse.dateTime.toDate())
    }
}
