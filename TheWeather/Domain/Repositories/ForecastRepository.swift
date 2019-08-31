//
//  ForecastRepository.swift
//  TheWeather
//
//  Created by Victor on 31/08/2019.
//  Copyright © 2019 Victor Rejano. All rights reserved.
//

import Foundation

final class ForecastRepository {
    
    fileprivate weak var weatherRepository: WeatherRepository!
    static let shared = ForecastRepository()
    
    private init() {
        weatherRepository = WeatherRepository.getInstance()
    }
    
}

extension ForecastRepository {
    
    func getForecastFor(place: Place, success: onSuccess<Forecast>, failure: onFailure) {
        
    }
    
    func getForecastFor(place: Place, mtsAhead: Double? = nil, direction: CardinalDirection, success: onSuccess<Forecast>, failure: onFailure) {
        
        
    }
}
