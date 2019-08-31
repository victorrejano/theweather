//
//  Place.swift
//  TheWeather
//
//  Created by Victor on 29/08/2019.
//  Copyright © 2019 Victor Rejano. All rights reserved.
//

import Foundation

struct Place {
    
    let name: String?
    let location: Location

}

extension Place: Equatable {
    
    static func == (lhs: Place, rhs: Place) -> Bool {
        return lhs._proxyForEquality == rhs._proxyForEquality
    }
    
    fileprivate var _proxyForEquality: String {
        return "\(location.lat)\(location.lon)"
    }
    
}
