//
//  PlaceTests.swift
//  TheWeatherTests
//
//  Created by Victor on 29/08/2019.
//  Copyright © 2019 Victor Rejano. All rights reserved.
//

import XCTest
@testable import TheWeather

class PlaceTests: XCTestCase {
    var mockApiResponse: WeatherMapAPIResponse!
    var anotherMockApiResponse: WeatherMapAPIResponse!
    
    var place: Place!
    var anotherPlace: Place!
    
    override func setUp() {
        mockApiResponse = WeatherMapAPIResponse(
            name: "Málaga",
            location: Location(lat: 36.4310, lon: 4.2512),
            weather: [WeatherDesc(main: "Sunny", description: "So sunny", icon: nil)],
            measures: ClimateMeasurement(
                currentTemp: 28,
                maxTemp: 33,
                minTemp: 21,
                pressure: 1019.4,
                humidity: 85,
                seaLevel: 11,
                groundLevel: nil),
            wind: Wind(speed: 6, degrees: 35),
            rain: Rain(lastHour: 0.1, lastestThreeHours: 0.4),
            dateTime: 1485792967)
        
        anotherMockApiResponse = WeatherMapAPIResponse(
            name: "Kiev",
            location: Location(lat: 50.2700, lon: 30.3124),
            weather: [WeatherDesc(main: "Clouds", description: "Partially cloud", icon: nil)],
            measures: ClimateMeasurement(
                currentTemp: 22,
                maxTemp: 28,
                minTemp: 17,
                pressure: 1019.4,
                humidity: 11,
                seaLevel: 179,
                groundLevel: nil),
            wind: Wind(speed: 6, degrees: 35),
            rain: Rain(lastHour: 0.1, lastestThreeHours: 0.4),
            dateTime: 1485792967)
        
        place = PlaceMapper.map(mockApiResponse)
        anotherPlace = PlaceMapper.map(anotherMockApiResponse)
    }
    
    func testPlaceEquality() {
        XCTAssertNotEqual(place, anotherPlace)
        
        let samePlace = PlaceMapper.map(mockApiResponse)
        XCTAssertEqual(place, samePlace)
    }

}
