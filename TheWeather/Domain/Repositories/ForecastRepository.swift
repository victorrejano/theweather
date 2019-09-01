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
    
    func getForecastFromCardinalPoints(origin: Place, success: @escaping onSuccess<[Forecast]>, failure: @escaping onFailure) {
        
        var forecasts: [Forecast] = []
        var placesToSearch: [Place] = [origin]
        
        CardinalDirection.allCases.forEach {
            direction in
            placesToSearch.append(
                PlaceCalculatorHelper.calculate(
                    origin: origin,
                    cardinalDirection: direction
                )
            )
        }
        
        DispatchQueue.global(qos: .background).async {
            let group = DispatchGroup()
            
            for place in placesToSearch {
                
                group.enter()
                
                self.getForecastFor(place: place, success: {
                    forecast, message in
                    
                    if let _ = forecast {
                        forecasts.append(forecast!)
                    }
                    
                    group.leave()
                    
                }, failure: {
                    error in
                    // No handle a single request error
                    group.leave()
                })
            }
            
            group.wait()
            
            DispatchQueue.main.async {
                // If all responses fails
                if forecasts.isEmpty {
                    failure(CustomError(code: nil, message: "Couldn't retrieve any data"))
                    return
                }
                
                success(forecasts, "Successfull")
            }
            
        }
    }
    
}
