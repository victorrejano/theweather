//
//  SearchViewPresenter.swift
//  TheWeather
//
//  Created by Victor on 31/08/2019.
//  Copyright © 2019 Victor Rejano. All rights reserved.
//

import Foundation

final class SearchViewPresenter {
    
    private let _forecastRepository: ForecastRepository
    private let _searchViewDelegate: SearchViewDelegate!
    
    init(forecastRepository: ForecastRepository, delegate: SearchViewDelegate) {
        _forecastRepository = forecastRepository
        _searchViewDelegate = delegate
    }
    
    func displayAutoCompleteViewController(_ controller: SearchViewController) {
        
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = controller
        
        // Specify the place data types to return.
        let fields: GMSPlaceField = GMSPlaceField(rawValue: UInt(GMSPlaceField.name.rawValue) |
            UInt(GMSPlaceField.placeID.rawValue) |
            UInt(GMSPlaceField.coordinate.rawValue))!
        autocompleteController.placeFields = fields
        
        // Specify a filter.
        let filter = GMSAutocompleteFilter()
        filter.type = .region
        autocompleteController.autocompleteFilter = filter
        
        // Display the autocomplete view controller.
        present(autocompleteController, animated: true, completion: nil)
    }
}
