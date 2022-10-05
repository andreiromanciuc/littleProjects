//
//  WeatherManagerDelegate.swift
//  weatherApp
//
//  Created by Andrei Romanciuc on 21.09.2022.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}
