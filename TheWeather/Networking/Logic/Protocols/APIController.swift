//
//  APIController.swift
//  TheWeather
//
//  Created by Victor on 30/08/2019.
//  Copyright © 2019 Victor Rejano. All rights reserved.
//

import Foundation

typealias APIParams = [(String, String)]
typealias onSuccess<T> = (T?, String?) -> Void
typealias onFailure = (CustomError) -> Void

protocol APIController {
    
    var _urlBase: String { get }
    var _apiKey: String { get }
    
    func getURL(params: APIParams, path: String) -> URL?
}

struct CustomError {
    
    let code: String?
    let message: String
    
}
