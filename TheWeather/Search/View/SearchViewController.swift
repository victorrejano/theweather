//
//  SearchViewController.swift
//  TheWeather
//
//  Created by Victor on 29/08/2019.
//  Copyright © 2019 VictorRejano. All rights reserved.
//

import UIKit
import GooglePlaces
import GoogleMaps

protocol SearchViewDelegate: class {
    func startLoading()
    func finishLoading()
    func displayAutocompleteViewController()
    func displayForecast(forecasts: [Forecast])
}

class SearchViewController: UIViewController {
    
    // MARK - Properties
    @IBOutlet weak var mapView: GMSMapView!
    private lazy var _presenter: SearchViewPresenter = {
        SearchViewPresenter(forecastRepository: ForecastRepository.shared, delegate: self)
    }()
    
    // MARK - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareView()
    }
    
    // MARK - View methods
    fileprivate func prepareView() {
        
        // Initial map's position
        let camera = GMSCameraPosition.camera(withLatitude: 0, longitude: 0, zoom: GoogleServicesConstants.DEFAULT_MAP_ZOOM)
        let map = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.addSubview(map)
        
        // Search button
        let searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(displayAutocompleteViewController))
        navigationItem.rightBarButtonItem = searchButton
        
        title = "Search weather info"
    }
    
    fileprivate func moveMapPositionTo(place: Place) {
        let camera = GMSCameraPosition.camera(withLatitude: place.location.lat, longitude: place.location.lon, zoom: GoogleServicesConstants.DEFAULT_MAP_ZOOM)
        mapView.animate(to: camera)
    }
    
    fileprivate func addMarkToMap(place: Place) {
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: place.location.lat, longitude: place.location.lon)
        
        marker.title = place.name ?? ""
        marker.snippet = "A snippet"
        marker.map = mapView
    }
}

// MARK - GMSDelegate
extension SearchViewController: GMSAutocompleteViewControllerDelegate {
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        
        dismiss(animated: true, completion: nil)
        
        
        
        // save selected place
        let newPlace = PlaceMapper.map(place)
        selectedPlace = newPlace
        
        // move map
        addMarkToMap(place: selectedPlace)
        moveMapPositionTo(place: selectedPlace)
        
        repository.getCurrentWeatherFor(newPlace,
        success: {
            [weak self]
            (result, message) in
            
            if let weather = result {
            
                let ac = UIAlertController(title: self?.selectedPlace.name!, message: "\(weather.temperature!.current)", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default))
                self?.present(ac, animated: true)
                return
            }
            
            
                                            
        }, failure: {
            [weak self]
            error in
            
            let ac = UIAlertController(title: "Error", message: error.message, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            self?.present(ac, animated: true)
            
        })
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}

extension SearchViewController: SearchViewDelegate {
    func startLoading() {
        
    }
    
    func finishLoading() {
        
    }
    
    @objc func displayAutocompleteViewController() {
        _presenter.displayAutoCompleteViewController(self)
    }
    
    func displayForecast(forecasts: [Forecast]) {
        
    }
}
