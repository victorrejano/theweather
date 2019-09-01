//
//  ViewController.swift
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
    fileprivate var retrievedForecasts: [Forecast]! = []
    
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
        
        // Initial map's position
        let camera = GMSCameraPosition.camera(withLatitude: 0.0, longitude: 0.0, zoom: 0.0)
        let map = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.addSubview(map)
        
        // Search button
        let searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(autocompleteClicked(_:)))
        navigationItem.rightBarButtonItem = searchButton
        
        tableView.dataSource = self
        tableView.delegate = self
        
        title = "Search weather info"
    }
    
    fileprivate func moveMapPositionTo(place: Place) {
        let camera = GMSCameraPosition.camera(withLatitude: place.location.lat, longitude: place.location.lon, zoom: GoogleServicesConstants.DEFAULT_MAP_ZOOM)
        mapView.camera = camera
        mapView.animate(to: camera)
    }
    
    fileprivate func addMarkToMap(forecast: Forecast) {
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
    }
    
    // Present the Autocomplete view controller when the button is pressed.
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
    
    func showLoadingView() {
        activityIndicator.isHidden = false
    }
    
    func hideLoadingView() {
        activityIndicator.isHidden = true
    }
}

// MARK - GMSDelegate
extension SearchViewController: GMSAutocompleteViewControllerDelegate {
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        
        dismiss(animated: true, completion: nil)
    
        // Clear older data
        mapView.clear()
        
        showLoadingView()
        
        // save selected place
        let newPlace = PlaceMapper.map(place)
        selectedPlace = newPlace
        
        moveMapPositionTo(place: newPlace)
        
        repository.getForecastFromCardinalPoints(origin: selectedPlace, success: {
            [weak self]
            results, message in
            
            results!.forEach {
                forecast in
                self?.retrievedForecasts = results!
                self?.tableView.reloadData()
                self?.stackView.isHidden = false
            }
            
            self?.hideLoadingView()
            
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

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return retrievedForecasts.isEmpty ? 0 : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastInfoCell", for: indexPath)
        
        switch indexPath.section {
        case 0:
            let forecast = retrievedForecasts[0]
            cell.textLabel?.text = forecast.place.name!
            cell.detailTextLabel?.text = "\(forecast.weather.temperature!.current) ºC"
            cell.imageView?.image = UIImage(named: "temperature-icon")
        case 1:
            let forecast = retrievedForecasts[0]
            cell.textLabel?.text = forecast.place.name!
            cell.detailTextLabel?.text = "\(forecast.weather.wind!.speed) kms/h"
            cell.imageView?.image = UIImage(named: "wind-icon")
        case 2:
            let forecast = retrievedForecasts[0]
            cell.textLabel?.text = forecast.place.name!
            cell.detailTextLabel?.text = "\(forecast.weather.humidity!.percentage) º%"
            cell.imageView?.image = UIImage(named: "humidity-icon")
        case 3:
            let forecast = retrievedForecasts[0]
            cell.textLabel?.text = forecast.place.name!
            cell.detailTextLabel?.text = "No rain"
            cell.imageView?.image = UIImage(named: "rain-icon")
        default:
            break
        }
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch section {
        case 0:
            return "Highest temperature"
        case 1:
            return "Highest wind"
        case 2:
            return "Highest humidity"
        case 3:
            return "Highest rain"
        default:
            return ""
        }
    }

}
