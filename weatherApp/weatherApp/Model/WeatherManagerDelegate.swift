//
//  WeatherManagerDelegate.swift
//  weatherApp
//
//  Created by Andrei Romanciuc on 21.09.2022.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weather: WeatherModel)
}
