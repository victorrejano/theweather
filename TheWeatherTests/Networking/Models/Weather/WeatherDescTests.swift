//
//  WeatherDescTests.swift
//  TheWeatherTests
//
//  Created by Victor on 29/08/2019.
//  Copyright © 2019 Victor Rejano. All rights reserved.
//

import XCTest
@testable import TheWeather

class WeatherDescTests: XCTestCase {
    var jsonData: Data!
    lazy var encoder: JSONEncoder! = { JSONEncoder() }()
    lazy var decoder: JSONDecoder! = { JSONDecoder() }()
    
    let resourceName: String = "weather"
    
    override func setUp() {
        guard let dataURL = Bundle.main.url(forResource: resourceName, withExtension: "json")
            else {
                return assertionFailure("Resource \(resourceName) not found")
        }
        
        jsonData = try! Data(contentsOf: dataURL)
    }
    
    func testDecodeImpl() {
        let decodedObject = try! decoder.decode(WeatherDesc.self, from: jsonData)
        XCTAssertNotNil(decodedObject)
    }
    
    func testEncodeImpl() {
        let decodedObject = try! decoder.decode(WeatherDesc.self, from: jsonData)
        let encodedObject = try! encoder.encode(decodedObject)
        XCTAssertNotNil(encodedObject)
    }

}
