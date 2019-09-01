//
//  ForecastQualifierControllerTests.swift
//  TheWeatherTests
//
//  Created by Victor on 01/09/2019.
//  Copyright © 2019 Victor Rejano. All rights reserved.
//

import XCTest
@testable import TheWeather

class ForecastQualifierControllerTests: XCTestCase {
    private var forecasts: [Forecast]!
    
    private var higherTemperaturePlace: Place!
    private var higherRainPlace: Place!
    private var higherWindPlace: Place!
    private var higherHumidityPlace: Place!
    
    private var controller: ForecastQualifierController!
    
    override func setUp() {
        higherRainPlace = Place(
            name: "higherRainPlace",
            location: Location(
                lat: 1,
                lon: 1)
        )
        higherWindPlace = Place(
            name: "higherWindPlace",
            location: Location(
                lat: 2,
                lon: 2)
        )
        higherTemperaturePlace = Place(
            name: "higherTemperaturePlace",
            location: Location(
                lat: 3,
                lon: 3)
        )
        higherHumidityPlace = Place(
            name: "higherHumidityPlace",
            location: Location(
                lat: 4,
                lon: 4)
        )
        
        forecasts = [
            Forecast(
                place: higherRainPlace,
                weather: Weather(
                    temperature: Temperature(max: 20, min: 15, current: 25),
                    humidity: nil,
                    rain: Rain(lastHour: 37, lastestThreeHours: 98),
                    wind: Wind(speed: 5, degrees: 95),
                    date: Date())),
            Forecast(
                place: higherTemperaturePlace,
                weather: Weather(
                    temperature: Temperature(max: 48, min: 15, current: 48),
                    humidity: nil,
                    rain: nil,
                    wind: nil,
                    date: Date())),
            Forecast(
                place: higherWindPlace,
                weather: Weather(
                    temperature: nil,
                    humidity: Humidity(percentage: 15),
                    rain: Rain(lastHour: 17, lastestThreeHours: 31),
                    wind: Wind(speed: 85, degrees: 180),
                    date: Date())),
            Forecast(
                place: higherHumidityPlace,
                weather: Weather(
                    temperature: Temperature(max: 15, min: -3, current: 7),
                    humidity: Humidity(percentage: 75),
                    rain: Rain(lastHour: 25, lastestThreeHours: 98),
                    wind: nil,
                    date: Date())),
        ]
        
        controller = ForecastQualifierController()
        controller.replaceForecasts(forecasts)
    }
    
    func testHighestTemperatureForecast() {
        let place = controller.getForecastWithQualifier(.moreTemperature).place
        XCTAssertEqual(place, higherTemperaturePlace)
    }
    
    func testHighestWindForecast() {
        let place = controller.getForecastWithQualifier(.moreWind).place
        XCTAssertEqual(place, higherWindPlace)
    }
    
    func testHighestRainForecast() {
        let place = controller.getForecastWithQualifier(.moreRain).place
        XCTAssertEqual(place, higherRainPlace)
    }
    
    func testHighestHumidityForecast() {
        let place = controller.getForecastWithQualifier(.moreHumidity).place
        XCTAssertEqual(place, higherHumidityPlace)
    }

}
