//
//  WeatherMapper.swift
//  TheWeather
//
//  Created by Victor on 29/08/2019.
//  Copyright © 2019 Victor Rejano. All rights reserved.
//

import Foundation

final class WeatherMapper {
    
    class func map(_ apiResponse: WeatherMapAPIResponse) -> Weather {
        return Weather(
            temperature: TemperatureMapper.map(apiResponse),
            humidity: HumidityMapper.map(apiResponse),
            rain: apiResponse.rain,
            wind: apiResponse.wind,
            date: apiResponse.dateTime.toDate())
    }
}
