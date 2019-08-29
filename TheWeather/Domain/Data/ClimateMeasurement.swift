//
//  ClimateMeasurement.swift
//  WeatherApp
//
//  Created by Victor on 29/08/2019.
//  Copyright © 2019 VictorRejano. All rights reserved.
//

import Foundation

struct ClimateMeasurement: Codable {
    
    let currentTemp: Float
    let maxTemp: Float
    let minTemp: Float
    let pressure: Float
    let humidity: Float
    let seaLevel: Float?
    let groundLevel: Float?
    
}

extension ClimateMeasurement {
    
    enum CodingKeys: String, CodingKey {
        case currentTemp = "temp"
        case maxTemp = "temp_max"
        case minTemp = "temp_min"
        case pressure
        case humidity
        case seaLevel = "sea_level"
        case groundLevel = "grnd_level"
    }
    
}
