//
//  CoinCurrency.swift
//  BitcoinPrice
//
//  Created by Andrei Romanciuc on 22.09.2022.
//

import Foundation

struct CoinCurrency {
    let currency: String
    let value: Double
    
    var valueString: String {
        return String(format: "%.2f", value)
    }
}
