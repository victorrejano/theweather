//
//  WeatherRepository.swift
//  TheWeather
//
//  Created by Victor on 30/08/2019.
//  Copyright © 2019 Victor Rejano. All rights reserved.
//

import Foundation

final class WeatherRepository {
    
    fileprivate static var _shared = WeatherRepository()
    fileprivate var provider: WeatherProvider!
    
    class func getInstance(_ origin: Provider? = nil) -> WeatherRepository {
        
        // If user specifies origin
        if let origin = origin {
            
            switch origin {
            case .mock:
                if !(_shared.provider is OpenWeatherAPI) {
                    _shared.provider = OpenWeatherAPI()
                }
                
                return _shared
            default:
                if !(_shared.provider is OpenWeatherAPI) {
                    _shared.provider = OpenWeatherAPI()
                }
                
                return _shared
            }
        }
        
        // Set openWeather as default provider
        if _shared.provider == nil {
            _shared.provider = OpenWeatherAPI()
        }
        
        return _shared
    }
    
    private init() {}
    
    enum Provider {
        case openWeather
        case mock
    }
}

extension WeatherRepository {
    
    func getCurrentWeatherFor(_ place: Place, success: @escaping (Weather?, String?) -> Void, failure: @escaping (CustomError) -> Void) {
        provider.getCurrentWeatherFor(place, success: success, failure: failure)
    }
}
