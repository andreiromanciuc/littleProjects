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
                self.getTemperatureFromResult()
            }
        }
    }
    
    func getTemperatureFromResult() -> Int? {
        var index: Int = 0
        let actualHour = Calendar.current.component(.hour, from: Date())
        
        guard let answer = result else { return nil }
        for date in answer.hourly.time {
            let hour = Calendar.current.component(.hour, from: date)
            if hour == actualHour {
                let response = answer.hourly.time.firstIndex(of: date) ?? 0
                index = response + 1
                tempLbl.text = String(answer.hourly.temperature_2m[index])
                return index
            }
        }
        
        return nil
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let data = result else { return 0 }
        return tableView == hourlyTabel ? data.hourly.time.count : data.daily.temperature_2m_max.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == hourlyTabel,
                let cell = tableView.dequeueReusableCell(withIdentifier: "hourlyCell") as? FirstTableViewCell {
            
            if let data = result {
                let day = data.hourly.time[indexPath.row].description
                let start = day.index(day.startIndex, offsetBy: 10)
                let end = day.index(day.startIndex, offsetBy: 15)
                let range = start...end
                let newString = String(day[range])
                cell.hourLabel.text = String(day.prefix(10)) + newString
                
                cell.temperatureLabel.text = String(data.hourly.temperature_2m[indexPath.row])
            }
            
                return cell
            } else if tableView == dailyTabel,
                let cell = tableView.dequeueReusableCell(withIdentifier: "dailyCell") as? SecondTableViewCell {
                
                if let data = result {
                    let day = data.daily.time[indexPath.row].description
                    let response = String(day.prefix(10))
                    cell.dayLabel.text = response
                    
                    cell.temperatureLabel.text = String(data.daily.temperature_2m_max[indexPath.row])
                }
                
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

