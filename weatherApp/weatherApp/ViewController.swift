//
//  ViewController.swift
//  weatherApp
//
//  Created by Andrei Romanciuc on 24.08.2022.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    let locationManager = CLLocationManager()
    var coordinates = CLLocationCoordinate2D()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        WeatherServer().getWeather(latitude: coordinates.latitude, longitude: coordinates.longitude)
        
    }
    
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locations.first != nil {
            coordinates = locations.first!.coordinate
        }
    }
}

