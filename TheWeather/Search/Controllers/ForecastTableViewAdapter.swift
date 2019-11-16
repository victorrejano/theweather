//
//  ForecastTableViewAdapter.swift
//  TheWeather
//
//  Created by Victor on 01/09/2019.
//  Copyright © 2019 Victor Rejano. All rights reserved.
//

import UIKit

protocol ForecastTableViewAdapterDelegate {
    func didSelectRow(index: IndexPath, selection: Forecast)
}

final class ForecastTableViewAdapter: NSObject {
    fileprivate let forecastSource = ForecastQualifierController()
    fileprivate let _delegate: ForecastTableViewAdapterDelegate!
    fileprivate weak var _tableView: UITableView!
    
    func replaceData(data: [Forecast]) {
        forecastSource.replaceForecasts(data)
        _tableView.reloadData()
    }
    
    init(delegate: ForecastTableViewAdapterDelegate, tableView: UITableView) {
        _delegate = delegate
        _tableView = tableView
        super.init()
    }
}

extension ForecastTableViewAdapter: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecastSource.count == 0 ? 0 : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastInfoCell", for: indexPath)
        
        var forecast: Forecast!
        let qualifier = Forecast.Qualifier.init(rawValue: indexPath.section)!
        
        switch qualifier {
            
        case .moreTemperature:
            forecast = forecastSource.getForecastWithQualifier(.moreTemperature)
            cell.detailTextLabel?.text = "\(forecast.weather.temperature!.current) ºC"
            cell.imageView?.image = UIImage(named: "temperature-icon")
            
        case .moreWind:
            forecast = forecastSource.getForecastWithQualifier(.moreWind)
            cell.detailTextLabel?.text = "\(forecast.weather.wind!.speed) kms/h"
            cell.imageView?.image = UIImage(named: "wind-icon")
            
        case .moreHumidity:
            forecast = forecastSource.getForecastWithQualifier(.moreHumidity)
            cell.detailTextLabel?.text = "\(forecast.weather.humidity!.percentage) º%"
            cell.imageView?.image = UIImage(named: "humidity-icon")
            
        case .moreRain:
            forecast = forecastSource.getForecastWithQualifier(.moreRain)
            cell.detailTextLabel?.text = forecast.weather.rain != nil ? "\(forecast.weather.rain!.lastHour) mm" : "0 mm"
            cell.imageView?.image = UIImage(named: "rain-icon")
        }
        
        // Common setup
        cell.textLabel?.text = forecast.place.name!
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Forecast.Qualifier.allCases.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var forecast: Forecast!
        let qualifier = Forecast.Qualifier.init(rawValue: indexPath.section)!
        
        switch qualifier {
        case .moreTemperature:
            forecast = forecastSource.getForecastWithQualifier(.moreTemperature)
        case .moreWind:
            forecast = forecastSource.getForecastWithQualifier(.moreWind)
        case .moreHumidity:
            forecast = forecastSource.getForecastWithQualifier(.moreHumidity)
        case .moreRain:
            forecast = forecastSource.getForecastWithQualifier(.moreRain)
        }
        
        // notify
        _delegate.didSelectRow(index: indexPath, selection: forecast)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        let qualifier = Forecast.Qualifier.init(rawValue: section)!
        
        switch qualifier {
        case .moreTemperature:
            return "Highest temperature"
        case .moreWind:
            return "Fastest wind"
        case .moreHumidity:
            return "Highest humidity"
        case .moreRain:
            return "Highest rain"
        }
    }
}
