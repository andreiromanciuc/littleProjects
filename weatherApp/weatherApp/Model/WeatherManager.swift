//
//  WeatherManager.swift
//  weatherApp
//
//  Created by Andrei Romanciuc on 20.09.2022.
//

import Foundation

struct WeatherManager {
    let weatherUrl = "https://api.openweathermap.org/data/2.5/weather?appid=91913c428ae3ae7cdeae79c38be4cca7&units=metric"
    
    func fetchWeather(cityName: String){
        let urlString = "\(weatherUrl)&q=\(cityName)"
        
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String) {
        
        if let url = URL(string: urlString) {
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil{
                    print(error!)
                    return
                }
                
                if let safeData = data {
                    self.parseJSON(weatherData: safeData)
                }
            }
            
            task.resume()
        }
    }
    
    func parseJSON(weatherData: Data){
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let temp = decodedData.main.temp
            let id = decodedData.weather[0].id
            let name = decodedData.name
            
            let weather = WeatherModel(conditionId: id, cityName: name, temerature: temp)
            print(weather.temperatureString)
            
        } catch {
            print(error)
        }
    }
    
    
}
