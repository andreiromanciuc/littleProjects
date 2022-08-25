//
//  ViewController.swift
//  weatherApp
//
//  Created by Andrei Romanciuc on 24.08.2022.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tempLbl: UILabel!
    @IBOutlet weak var hourlyTabel: UITableView!
    @IBOutlet weak var dailyTabel: UITableView!
    
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var tempHourly: UILabel!
    
    @IBOutlet weak var tempDaily: UILabel!
    @IBOutlet weak var date: UILabel!
    
    let locationManager = CLLocationManager()
    var coordinates = CLLocationCoordinate2D()
    var result: Result?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        hourlyTabel.delegate = self
        hourlyTabel.dataSource = self
        
        dailyTabel.delegate = self
        dailyTabel.dataSource = self
        
        
        WeatherServer().getWeather(latitude: self.coordinates.latitude, longitude: self.coordinates.longitude) { (result) in
            self.result = result
            
            DispatchQueue.main.async {
                self.hourlyTabel.reloadData()
                self.dailyTabel.reloadData()
            }
        }
        
        getTemperatureFromResult()

    }
    
    func getTemperatureFromResult() {
        var index: Int = 0
        let actualHour = Calendar.current.component(.hour, from: Date())
        
        guard let answer = result else {return}
        for date in answer.hourly.time {
            let hour = Calendar.current.component(.hour, from: date)
            if hour == actualHour{
                guard let response = answer.hourly.time.firstIndex(of: date) else {return}
                index = response
            }
        }
        
        tempLbl.text = String(answer.hourly.temperature_2m[index])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableView == hourlyTabel ? hourlyTabel.numberOfSections : dailyTabel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == hourlyTabel,
                let cell = tableView.dequeueReusableCell(withIdentifier: "hourlyCell") as? FirstTableViewCell {
                
                return cell
            } else if tableView == dailyTabel,
                let cell = tableView.dequeueReusableCell(withIdentifier: "dailyCell") as? SecondTableViewCell {
                return cell
            }

            return UITableViewCell()
    }
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let result = locations.first?.coordinate else {return}
        coordinates = result
    }
}

