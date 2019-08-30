//
//  OpenWeatherMapAPIWeatherProvider.swift
//  TheWeather
//
//  Created by Victor on 30/08/2019.
//  Copyright © 2019 Victor Rejano. All rights reserved.
//

import Foundation

final class OpenWeatherMapAPIWeatherProvider: APIController {
    
    static let shared = OpenWeatherMapAPIWeatherProvider()
    var _urlBase: String {
        return "samples.openweathermap.org"
    }
    
    var _apiKey: String {
        return "1da4e42e3b577469204fe4489085126e"
    }
    
    func getURL(params: APIParams, path: String) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = _urlBase
        components.path = "data/2.5/\(path)"
        components.queryItems = [URLQueryItem(name: "appid", value: _apiKey)]
        return components.url
    }
    
    private init() {}
    
}

extension OpenWeatherMapAPIWeatherProvider: WeatherProvider {
    
    enum OpenWeatherMapAPIRoutes: String {
        case forPlace = "weather"
    }
    
    func getCurrentWeatherFor(_ place: Place, success: ([Weather]?, String?) -> Void, failure: (CustomError) -> Void) {
        
        let lat = String(place.location.lat)
        let lon = String(place.location.lon)
        
        guard let url = getURL(
            params: [
                ("lat", lat),
                ("lon", lon)
            ], path: OpenWeatherMapAPIRoutes.forPlace.rawValue) else {
                failure(CustomError(code: nil, message: "Malformed query or url"))
                return
        }
        
        Alamofire.request
    }
    
}
