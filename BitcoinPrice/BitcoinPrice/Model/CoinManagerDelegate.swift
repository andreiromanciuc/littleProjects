//
//  CoinManagerDelegate.swift
//  BitcoinPrice
//
//  Created by Andrei Romanciuc on 22.09.2022.
//

import Foundation

protocol CoinManagerDelegate {
    
    func didFailWithError(_ error: Error)
    func didUpdateCurrencyPrice(_ currency: CoinCurrency)
    
}
