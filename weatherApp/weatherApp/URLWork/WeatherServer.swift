//
//  WeatherServer.swift
//  weatherApp
//
//  Created by Andrei Romanciuc on 25.08.2022.
//

import Foundation

extension DateFormatter {
  static let iso8601Full: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
    formatter.calendar = Calendar(identifier: .iso8601)
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    formatter.locale = Locale(identifier: "en_US_POSIX")
    return formatter
  }()
}

struct WeatherServer {
    
    func getWeather(latitude: Double, longitude: Double) {
        
        let queryItems = [URLQueryItem(name: "latitude", value: String(latitude)),
                          URLQueryItem(name: "longitude", value: String(longitude)),
                          URLQueryItem(name: "hourly", value: "temperature_2m"),
                          URLQueryItem(name: "daily", value: "temperature_2m_max,temperature_2m_min"),
                          URLQueryItem(name: "timezone", value: "auto")]
        
        guard var urlComps = URLComponents(string: "https://api.open-meteo.com/v1/forecast") else { return }
        urlComps.queryItems = queryItems
        guard let url = urlComps.url else { return }
        
        URLSession.shared.dataTask(with: url){ (data, response, error) in
            
            if let newData = data {
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
                    let result = try decoder.decode(Result.self, from: newData)
                    print(result)
                }
                catch{
                    print(error)
                }
            }
            else {
                print("Can't receive data from API")
            }
            
        }.resume()
    }
}
