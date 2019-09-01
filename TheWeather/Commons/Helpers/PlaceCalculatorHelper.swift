//
//  PlaceCalculatorHelper.swift
//  TheWeather
//
//  Created by Victor on 31/08/2019.
//  Copyright © 2019 Victor Rejano. All rights reserved.
//

import Foundation
import MapKit

enum CardinalDirection {
    case north
    case south
    case east
    case west
}

extension CardinalDirection: CaseIterable {}

final class PlaceCalculatorHelper {
    
    static let DEFAULT_DISTANCE: Double = 200000
    
    class func calculate(origin: Place, distanceInMts: Double? = DEFAULT_DISTANCE, cardinalDirection: CardinalDirection) -> Place {
        
        let location = try! newLocationFrom(origin: origin.location, direction: cardinalDirection, meters: distanceInMts!)
        
        return Place(
            name: "\(location.lat),\(location.lon)",
            location: location
        )
    }
    
    private class func newLocationFrom(origin: Location, direction: CardinalDirection, meters: Double) throws -> Location {
        
        // Negative distance not allowed
        if meters < 0 {
            throw PlaceCalculatorHelper.providedDistanceShouldBeNaturaNumber
        }
        
        // Parse to coordinate
        var region: MKCoordinateRegion
        let currentCoordinate = CLLocationCoordinate2D(latitude: origin.lat, longitude: origin.lon)
        
        // Create coordinate region based on original coordinate, distance provided and direction
        switch direction {
        case .north:
            region = MKCoordinateRegion(center: currentCoordinate, latitudinalMeters: meters, longitudinalMeters: 0)
        case .south:
            region = MKCoordinateRegion(center: currentCoordinate, latitudinalMeters: -meters, longitudinalMeters: 0)
        case .east:
            region = MKCoordinateRegion(center: currentCoordinate, latitudinalMeters: 0, longitudinalMeters: meters)
        case .west:
            region = MKCoordinateRegion(center: currentCoordinate, latitudinalMeters: 0, longitudinalMeters: -meters)
            
        }
        
        let newLat = currentCoordinate.latitude + region.span.latitudeDelta
        let newLon = currentCoordinate.longitude + region.span.longitudeDelta
        
        return Location(lat: newLat, lon: newLon)
        
    }
    
    enum PlaceCalculatorHelper: Error {
        case providedDistanceShouldBeNaturaNumber
    }
    
}
