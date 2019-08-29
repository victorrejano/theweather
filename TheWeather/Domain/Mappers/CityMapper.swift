//
//  CityMapper.swift
//  TheWeather
//
//  Created by Victor on 29/08/2019.
//  Copyright © 2019 Victor Rejano. All rights reserved.
//

import Foundation

final class CityMapper {
    
    class func map(_ apiResponse: WeatherMapAPIResponse) -> City {
        return City(
            id: UUID(),
            name: apiResponse.name,
            countryCode: nil,
            zipcode: nil,
            location: apiResponse.location,
            weatherInfo: WeatherInfoMapper.map(apiResponse))
    }
}
