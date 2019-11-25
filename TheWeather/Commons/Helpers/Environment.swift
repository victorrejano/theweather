//
//  Environment.swift
//  TheWeather
//
//  Created by Victor Rejano on 25/11/2019.
//  Copyright © 2019 Victor Rejano. All rights reserved.
//

import Foundation

public enum Environment {

  private static let infoDictionary: [String: Any] = {
    guard let dict = Bundle.main.infoDictionary else {
      fatalError("Plist file not found")
    }
    return dict
  }()
    
    public enum OpenWeather {
        
        static var apiKey: String {
            return Environment.infoDictionary["OPEN_WEATHER_API_KEY"] as! String
        }
        
        static var rootURL: String {
            return Environment.infoDictionary["OPEN_WEATHER_URL"] as! String
        }
    }

    public enum GoogleService {
        static var apiKey: String {
            return Environment.infoDictionary["GOOGLE_SERVICE_API_KEY"] as! String
        }
    }
}
