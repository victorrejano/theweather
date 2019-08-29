//
//  Temperature.swift
//  TheWeather
//
//  Created by Victor on 29/08/2019.
//  Copyright © 2019 Victor Rejano. All rights reserved.
//

import Foundation

struct Temperature {
    
    let max: Float
    let min: Float
    let current: Float
    
}

extension Temperature {
    
    fileprivate var _proxyForEquality: String {
        get {
            return "\(max)\(min)\(current)"
        }
    }
    
    fileprivate var _proxyForAscendingComparison: String {
        return "\(max)"
    }
    
    fileprivate var _proxyForDescendingComparison: String {
        return "\(min)"
    }
    
}

extension Temperature: Equatable, Comparable {
    
    static func < (lhs: Temperature, rhs: Temperature) -> Bool {
        return lhs._proxyForDescendingComparison < rhs._proxyForDescendingComparison
    }
    
    static func > (lhs: Temperature, rhs: Temperature) -> Bool {
        return lhs._proxyForAscendingComparison < rhs._proxyForAscendingComparison
    }
    
    static func == (lhs: Temperature, rhs: Temperature) -> Bool {
        return lhs._proxyForEquality == rhs._proxyForEquality
    }
    
}
