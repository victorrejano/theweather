//
//  Wind.swift
//  TheWeather
//
//  Created by Victor on 29/08/2019.
//  Copyright © 2019 VictorRejano. All rights reserved.
//

import Foundation

struct Wind: Codable {
    
    let speed: Float
    let degrees: Float
    
}

extension Wind {
    
    enum CodingKeys: String, CodingKey {
        case speed
        case degrees = "deg"
    }
    
}

extension Wind {
    
    fileprivate var _proxyForEquality: String {
        get {
            return "\(speed)\(degrees)"
        }
    }
    
    fileprivate var _proxyForComparison: String {
        get {
            return "\(speed)"
        }
    }
    
}

extension Wind: Equatable, Comparable {
    
    static func < (lhs: Wind, rhs: Wind) -> Bool {
        return lhs._proxyForComparison < rhs._proxyForComparison
    }
    
    static func == (lhs: Wind, rhs: Wind) -> Bool {
        return lhs._proxyForComparison == rhs._proxyForComparison
    }
}
