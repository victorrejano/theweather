//
//  Forecast.swift
//  TheWeather
//
//  Created by Victor on 30/08/2019.
//  Copyright © 2019 Victor Rejano. All rights reserved.
//

import Foundation

struct Forecast {
    
    let place: Place
    let weather: Weather
    
    enum Qualifier: Int, CaseIterable {
        case moreWind
        case moreTemperature
        case moreRain
        case moreHumidity
    }
}
