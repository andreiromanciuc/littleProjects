//
//  CurrencyModel.swift
//  BitcoinPrice
//
//  Created by Andrei Romanciuc on 22.09.2022.
//

import Foundation

struct CurrencyModel: Decodable {
    
    var time: String
    var asset_id_base: String
    var asset_id_quote: String
    var rate: Double
    
}
