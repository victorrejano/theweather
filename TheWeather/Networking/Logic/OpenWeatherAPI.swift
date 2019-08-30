//
//  OpenWeatherMapAPI.swift
//  TheWeather
//
//  Created by Victor on 30/08/2019.
//  Copyright © 2019 Victor Rejano. All rights reserved.
//
import Alamofire
import Foundation

final class OpenWeatherAPI: APIController {
    
    static let shared = OpenWeatherAPI()
    var _urlBase: String {
        return OpenWeatherAPIConstants.URL_BASE
    }
    
    var _apiKey: String {
        return OpenWeatherAPIConstants.API_KEY
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

extension OpenWeatherAPI: WeatherProvider {
    
    enum OpenWeatherAPIRoutes: String {
        case forPlace = "weather"
    }
    
    func getCurrentWeatherFor(_ place: Place, success: @escaping (Weather?, String?) -> Void, failure: @escaping (CustomError) -> Void) {
        
        let lat = String(place.location.lat)
        let lon = String(place.location.lon)
        
        guard let url = getURL(
            params: [
                ("lat", lat),
                ("lon", lon)
            ], path: OpenWeatherAPIRoutes.forPlace.rawValue) else {
                failure(CustomError(code: nil, message: "Malformed query or url"))
                return
        }
        
        Alamofire.request(url).responseData { data in
            
            switch data.result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(WeatherMapAPIResponse.self, from: data)
                    success(WeatherMapper.map(result), nil)
                } catch {
                    failure(CustomError(code: nil, message: error.localizedDescription))
                }
            case .failure(let error):
                failure(CustomError(code: nil, message: error.localizedDescription))
            }
            
        }
    }
    
}
