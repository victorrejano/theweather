//
//  WeatherProvider.swift
//  TheWeather
//
//  Created by Victor on 30/08/2019.
//  Copyright © 2019 Victor Rejano. All rights reserved.
//

import Foundation

protocol WeatherProvider: class {
    
    func getCurrentWeatherFor(_ place: Place, success: @escaping onSuccess<Weather>, failure: @escaping onFailure)

}
