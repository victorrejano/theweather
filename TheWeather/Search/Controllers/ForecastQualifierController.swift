//
//  ForecastQualifierController.swift
//  TheWeather
//
//  Created by Victor on 01/09/2019.
//  Copyright © 2019 Victor Rejano. All rights reserved.
//

import Foundation

final class ForecastQualifierController {
    private var _forecasts: [Forecast]!
    var count: Int {
        return _forecasts.count
    }
    
    init() {
        _forecasts = []
    }
    
    func replaceForecasts(_ forecasts: [Forecast]) {
        _forecasts = forecasts
    }
    
    func getForecastWithQualifier(_ qualifier: Forecast.Qualifier) -> Forecast {
        
        switch qualifier {
        case .moreTemperature:
            return getHigherTemperatureForecast()
        case .moreHumidity:
            return getHigherHumidityForecast()
        case .moreRain:
            return getHigherRainForecast()
        case .moreWind:
            return getHigherWindForecast()
        }
    }
    
    private func getHigherTemperatureForecast() -> Forecast {
        
        return _forecasts.filter {
                $0.weather.temperature != nil
            }
            .max { forecast, otherForecast -> Bool in
                forecast.weather.temperature!.current < otherForecast.weather.temperature!.current
            }
            ?? _forecasts.first!
    }
    
    private func getHigherHumidityForecast() -> Forecast {
        
        return _forecasts.filter {
                $0.weather.humidity != nil
            }
            .max { forecast, otherForecast -> Bool in
                forecast.weather.humidity!.percentage < otherForecast.weather.humidity!.percentage
            }
            ?? _forecasts.first!
    }
    
    private func getHigherRainForecast() -> Forecast {
        
        return _forecasts.filter {
                $0.weather.rain != nil
            }
            .max { forecast, otherForecast -> Bool in
                forecast.weather.rain!.lastHour < otherForecast.weather.rain!.lastHour
            }
            ?? _forecasts.first!
    }
    
    private func getHigherWindForecast() -> Forecast {
        
        return _forecasts.filter {
                $0.weather.wind != nil
            }
            .max { forecast, otherForecast -> Bool in
                forecast.weather.wind!.speed < otherForecast.weather.wind!.speed
            }
            ?? _forecasts.first!
    }
    
}
