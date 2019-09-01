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

class SearchViewController: UIViewController {
    
    // MARK - Properties
    fileprivate var selectedPlace: Place! {
        didSet {
            title = "Forecast around \(selectedPlace.name!)"
        }
    }
    fileprivate var retrievedForecasts: [Forecast]! = [] {
        didSet {
            forecastTableViewAdapter.replaceData(data: retrievedForecasts)
        }
    }
    fileprivate var forecastTableViewAdapter: ForecastTableViewAdapter!
    
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var tableView: UITableView!
    
    let repository = ForecastRepository.shared
    
    // MARK - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareView()
    }
    
    // MARK - View methods
    fileprivate func prepareView() {
        
        title = "Search weather info"
        
        // Initial map's position
        let camera = GMSCameraPosition.camera(withLatitude: 0.0, longitude: 0.0, zoom: 0.0)
        let map = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.addSubview(map)
        
        // Search button
        let searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(autocompleteClicked(_:)))
        navigationItem.rightBarButtonItem = searchButton
        
        // TableView setup
        forecastTableViewAdapter = ForecastTableViewAdapter(delegate: self, tableView: tableView)
        tableView.dataSource = forecastTableViewAdapter
        tableView.delegate = forecastTableViewAdapter
        
    }
    
    fileprivate func moveMapPositionTo(place: Place) {
        let camera = GMSCameraPosition.camera(withLatitude: place.location.lat, longitude: place.location.lon, zoom: GoogleServicesConstants.DEFAULT_MAP_ZOOM)
        mapView.camera = camera
        mapView.animate(to: camera)
    }
    
    fileprivate func addMarkToMap(forecast: Forecast) {
        // Clear older marks
        mapView.clear()
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: forecast.place.location.lat, longitude: forecast.place.location.lon)
        
        marker.title = forecast.place.name ?? ""
        marker.snippet = """
        Temperature: \(forecast.weather.temperature!.current) ºC
        Humidity: \(forecast.weather.temperature!.current) %
        Rain in last hour: \(forecast.weather.rain?.lastHour != nil ? String(forecast.weather.rain!.lastHour) : "-") mm
        Wind: \(forecast.weather.wind?.speed != nil ? String(forecast.weather.wind!.speed) : "-") kms/h
        """
        
        marker.map = mapView
        mapView.selectedMarker = marker
    }
    
    @objc func autocompleteClicked(_ sender: UIButton) {
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
        
        // Display the autocomplete view controller.
        present(autocompleteController, animated: true, completion: nil)
    }
    
    private func showLoadingView() {
        activityIndicator.isHidden = false
    }
    
    private func hideLoadingView() {
        activityIndicator.isHidden = true
    }
}

extension SearchViewController: ForecastTableViewAdapterDelegate {
    
    func didSelectRow(index: IndexPath, selection: Forecast) {
        moveMapPositionTo(place: selection.place)
        addMarkToMap(forecast: selection)
    }
}

// MARK - GMSDelegate
extension SearchViewController: GMSAutocompleteViewControllerDelegate {
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        
        dismiss(animated: true, completion: nil)
        
        showLoadingView()
        
        // save selected place
        let newPlace = PlaceMapper.map(place)
        selectedPlace = newPlace
        
        repository.getForecastFromCardinalPoints(origin: selectedPlace, success: {
            [weak self]
            results, message in
            
            self?.hideLoadingView()
            
            guard let forecasts = results else {
                self?.hideLoadingView()
                let ac = UIAlertController(title: "Error", message: "Couldn't retrieve data, try it again later", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default))
                self?.present(ac, animated: true)
                return
            }
            
            forecasts.forEach {
                forecast in
                self?.retrievedForecasts = results!
                self?.tableView.reloadData()
                self?.stackView.isHidden = false
                
                // show location as selected
                let selectedPlaceForecast = results!.first {
                    [weak self]
                    item in item.place == self?.selectedPlace
                }
                
                if let _ = selectedPlaceForecast {
                    self?.addMarkToMap(forecast: selectedPlaceForecast!)
                    self?.moveMapPositionTo(place: selectedPlaceForecast!.place)
                } else {
                    let otherPlaceForecast = forecasts.first!
                    self?.addMarkToMap(forecast: otherPlaceForecast)
                    self?.moveMapPositionTo(place: otherPlaceForecast.place)
                }
            }
            
            }, failure: {
                [weak self]
                error in
                
                let ac = UIAlertController(title: "Error", message: "Couldn't retrieve data, try it again later", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default))
                self?.present(ac, animated: true)
                
                self?.hideLoadingView()
        })
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("Error: ", error.localizedDescription)
    }
    
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
