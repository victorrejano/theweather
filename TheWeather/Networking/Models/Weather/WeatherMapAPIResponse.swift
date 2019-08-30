//
//  WeatherMapAPIResponse.swift
//  WeatherApp
//
//  Created by Victor on 29/08/2019.
//  Copyright © 2019 VictorRejano. All rights reserved.
//

import Foundation

typealias Descriptions = [WeatherDesc]

struct WeatherMapAPIResponse: Codable {
    
    let name: String
    let location: Location
    let weather: Descriptions
    let measures: ClimateMeasurement?
    let wind: Wind?
    let rain: Rain?
    let dateTime: Int
    
}

extension WeatherMapAPIResponse {
    
    enum CodingKeys: String, CodingKey {
        case name
        case location = "coord"
        case weather
        case measures = "main"
        case wind
        case rain
        case dateTime = "dt"
    }
    
}
