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
    
    func getForecastFor(place: Place, success: @escaping onSuccess<Forecast>, failure: @escaping onFailure) {
        
        weatherRepository.getCurrentWeatherFor(place, success: {
            result, message in
            
            guard let weather = result else {
                failure(CustomError(code: nil, message: "No weather found"))
                return
            }
            
            let forecast = Forecast(
                place: place,
                weather: weather
            )
            
            success(forecast, message)
            
        }, failure: {
            error in
            failure(CustomError(code: nil, message: error.message))
        })
    }
    
    func getForecastFor(place: Place, mtsAhead: Double? = nil, direction: CardinalDirection, success: @escaping onSuccess<Forecast>, failure: @escaping onFailure) {
        
        let newPlace = PlaceCalculatorHelper.calculate(origin: place, cardinalDirection: direction)
        getForecastFor(place: newPlace, success: success, failure: failure)
    }
}
