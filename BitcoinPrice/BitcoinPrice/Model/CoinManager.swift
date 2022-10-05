//
//  CoinManager.swift
//  BitcoinPrice
//
//  Created by Andrei Romanciuc on 21.09.2022.
//

import Foundation

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "9A4E5B2F-9025-4B81-BA6A-5C020962F23F"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    var delegate: CoinManagerDelegate?

    func getCoinPrice(for currency: String) {
        let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        
        performRequest(urlString)
    }
    
    func performRequest(_ urlString: String){
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, result, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error!)
                }
                
                if let safedata = data {
                    if let currency = self.parseJSON(safedata){
                        self.delegate?.didUpdateCurrencyPrice(currency)
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func parseJSON(_ currency: Data) -> CoinCurrency? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CurrencyModel.self, from: currency)
            let currnecy = decodedData.asset_id_quote
            let value = decodedData.rate
            
            let coinCurrency = CoinCurrency(currency: currnecy, value: value)
            return coinCurrency
            
        } catch {
            self.delegate?.didFailWithError(error)
            return nil
        }
    }
}
