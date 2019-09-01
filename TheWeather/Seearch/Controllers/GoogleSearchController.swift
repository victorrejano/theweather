//
//  GoogleSearchController.swift
//  TheWeather
//
//  Created by Victor on 01/09/2019.
//  Copyright © 2019 Victor Rejano. All rights reserved.
//

import Foundation
import GooglePlaces

protocol GoogleSearchControllerDelegate {
    func didSelectPlace(selection: Place)
    func cancelledSearch()
}

final class GoogleSearchController: NSObject {
    fileprivate var _delegate: GoogleSearchControllerDelegate!
    
    init(delegate: GoogleSearchControllerDelegate) {
        _delegate = delegate
        super.init()
    }
    
    func setupAutocomplete() -> GMSAutocompleteViewController {
        
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        
        // Specify the place data types to return.
        let fields: GMSPlaceField = GMSPlaceField(rawValue: UInt(GMSPlaceField.name.rawValue) |
            UInt(GMSPlaceField.placeID.rawValue) |
            UInt(GMSPlaceField.coordinate.rawValue))!
        autocompleteController.placeFields = fields
        
        // Specify a filter.
        let filter = GMSAutocompleteFilter()
        filter.type = .region
        autocompleteController.autocompleteFilter = filter
        
        return autocompleteController
        
    }
}

extension GoogleSearchController: GMSAutocompleteViewControllerDelegate {
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        _delegate.didSelectPlace(selection: PlaceMapper.map(place))
    }
    
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("Error: ", error.localizedDescription)
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        _delegate.cancelledSearch()
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}
