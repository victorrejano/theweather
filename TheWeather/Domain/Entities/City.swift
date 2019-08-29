//
//  City.swift
//  TheWeather
//
//  Created by Victor on 29/08/2019.
//  Copyright © 2019 Victor Rejano. All rights reserved.
//

import Foundation

struct City {
    
    let id: UUID
    let name: String
    let countryCode: String?
    let zipcode: String?
    let location: Location
    let weatherInfo: WeatherInfo?
    
}

extension City: Equatable {
    
    static func == (lhs: City, rhs: City) -> Bool {
        return lhs._proxyForEquality == rhs._proxyForEquality
    }
    
    fileprivate var _proxyForEquality: String {
        return "\(name)\(location.lat)\(location.lon)"
    }
    
}
