//
//  Rain.swift
//  TheWeather
//
//  Created by Victor on 29/08/2019.
//  Copyright © 2019 Victor Rejano. All rights reserved.
//

import Foundation

struct Rain: Codable {
    
    let lastHour: Float
    let lastestThreeHours: Float
    
}

extension Rain {
    
    enum CodingKeys: String, CodingKey {
        case lastHour = "1h"
        case lastestThreeHours = "3h"
    }
    
}
