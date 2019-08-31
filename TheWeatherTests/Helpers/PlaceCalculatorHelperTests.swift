//
//  PlaceCalculatorHelperTests.swift
//  TheWeatherTests
//
//  Created by Victor on 31/08/2019.
//  Copyright © 2019 Victor Rejano. All rights reserved.
//

import XCTest
import MapKit
@testable import TheWeather

class PlaceCalculatorHelperTests: XCTestCase {
    
    var origin: Place!
    var originLocation: CLLocation!
    let deviationAllowed = 1.0 // Deviation allowed for calculated places up to 1 meter
    
    var northPlace: Place!
    var southPlace: Place!
    var eastPlace: Place!
    var westPlace: Place!

    override func setUp() {
        origin = Place(name: "Málaga", location: Location(lat: 36.7182169, lon: -4.484286313))
        originLocation = CLLocation(latitude: origin.location.lat, longitude: origin.location.lon)
    }

    func testCalculatePlaceToDefaultDistanceNorthExistence() {
        northPlace = PlaceCalculatorHelper.calculate(origin: origin, cardinalDirection: CardinalDirection.north)
        XCTAssertNotNil(northPlace)
    }
    
    func testCalculatePlaceToDefaultDistanceNorthAccuracy() {
        northPlace = PlaceCalculatorHelper.calculate(origin: origin, cardinalDirection: CardinalDirection.north)
        let location = CLLocation(latitude: northPlace.location.lat, longitude: northPlace.location.lon)
        let realDistance = originLocation.distance(from: location)
        XCTAssertEqual(realDistance, PlaceCalculatorHelper.DEFAULT_DISTANCE, accuracy: deviationAllowed)
    }
    
    func testCalculatePlaceToDefaultDistanceNorthDirection() {
        northPlace = PlaceCalculatorHelper.calculate(origin: origin, cardinalDirection: CardinalDirection.north)
        XCTAssertGreaterThan(northPlace.location.lat, origin.location.lat)
        XCTAssertEqual(northPlace.location.lon, origin.location.lon)
    }

    func testCalculatePlaceToDefaultDistanceSouthExistence() {
        southPlace = PlaceCalculatorHelper.calculate(origin: origin, cardinalDirection: CardinalDirection.south)
        XCTAssertNotNil(southPlace)
    }
    
    func testCalculatePlaceToDefaultDistanceSouthAccuracy() {
        southPlace = PlaceCalculatorHelper.calculate(origin: origin, cardinalDirection: CardinalDirection.south)
        let location = CLLocation(latitude: southPlace.location.lat, longitude: southPlace.location.lon)
        let realDistance = originLocation.distance(from: location)
        XCTAssertEqual(realDistance, PlaceCalculatorHelper.DEFAULT_DISTANCE, accuracy: deviationAllowed)
    }
    
    func testCalculatePlaceToDefaultDistanceSouthDirection() {
        southPlace = PlaceCalculatorHelper.calculate(origin: origin, cardinalDirection: CardinalDirection.south)
        XCTAssertLessThan(southPlace.location.lat, origin.location.lat)
        XCTAssertEqual(southPlace.location.lon, origin.location.lon)
    }
    
    func testCalculatePlaceToDefaultDistanceEastExistence() {
        eastPlace = PlaceCalculatorHelper.calculate(origin: origin, cardinalDirection: CardinalDirection.east)
        XCTAssertNotNil(eastPlace)
    }
    
    func testCalculatePlaceToDefaultDistanceEastAccuracy() {
        eastPlace = PlaceCalculatorHelper.calculate(origin: origin, cardinalDirection: CardinalDirection.east)
        let location = CLLocation(latitude: eastPlace.location.lat, longitude: eastPlace.location.lon)
        let realDistance = originLocation.distance(from: location)
        XCTAssertEqual(realDistance, PlaceCalculatorHelper.DEFAULT_DISTANCE, accuracy: deviationAllowed)
    }
    
    func testCalculatePlaceToDefaultDistanceEastDirection() {
        eastPlace = PlaceCalculatorHelper.calculate(origin: origin, cardinalDirection: CardinalDirection.east)
        XCTAssertGreaterThan(eastPlace.location.lon, origin.location.lon)
        XCTAssertEqual(eastPlace.location.lat, origin.location.lat)
    }
    
    func testCalculatePlaceToDefaultDistanceWestExistence() {
        westPlace = PlaceCalculatorHelper.calculate(origin: origin, cardinalDirection: CardinalDirection.west)
        XCTAssertNotNil(westPlace)
    }
    
    func testCalculatePlaceToDefaultDistanceWestAccuracy() {
        westPlace = PlaceCalculatorHelper.calculate(origin: origin, cardinalDirection: CardinalDirection.west)
        let location = CLLocation(latitude: westPlace.location.lat, longitude: westPlace.location.lon)
        let realDistance = originLocation.distance(from: location)
        XCTAssertEqual(realDistance, PlaceCalculatorHelper.DEFAULT_DISTANCE, accuracy: deviationAllowed)
    }
    
    func testCalculatePlaceToDefaultDistanceWestDirection() {
        westPlace = PlaceCalculatorHelper.calculate(origin: origin, cardinalDirection: CardinalDirection.west)
        XCTAssertLessThan(westPlace.location.lon, origin.location.lon)
        XCTAssertEqual(westPlace.location.lat, origin.location.lat)
    }

}
