//
//  PlacesProvider.swift
//  TheWeather
//
//  Created by Victor on 30/08/2019.
//  Copyright © 2019 Victor Rejano. All rights reserved.
//

import Foundation

protocol PlacesProvider: class {
    
    func getPlacesFor(name: String, success: onSuccess<[Place]>, failure: onFailure)
    
    func getPlacesFor(zipcode: String, success: onSuccess<[Place]>, failure: onFailure)
    
}
