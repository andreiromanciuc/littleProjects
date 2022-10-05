//
//  WeatherData.swift
//  weatherApp
//
//  Created by Andrei Romanciuc on 20.09.2022.
//

import Foundation


struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let id: Int
}

