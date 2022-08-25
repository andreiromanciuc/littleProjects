//
//  File.swift
//  weatherApp
//
//  Created by Andrei Romanciuc on 25.08.2022.
//

import Foundation

struct Result : Decodable {
    var timezone: String?
    var hourly: Time
    var daily: Temperature
}

struct Time : Decodable {
    var time : [Date]
    var temperature_2m: [Float]
}

struct Temperature : Decodable {
    var time: [String]
    var temperature_2m_max: [Float]
    var temperature_2m_min: [Float]
}
