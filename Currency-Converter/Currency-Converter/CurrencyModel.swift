//
//  CurrencyModel.swift
//  Currency-Converter
//
//  Created by Kristina Gelzinyte on 2/10/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

import Foundation

class CurrencyModel: Codable {
    var currency: String
    var currencyAmount: Double
    var totalTaxes: Double
    
    init(_ currency: String, _ currencyAmount: Double, totalTaxes: Double) {
        self.currency = currency
        self.currencyAmount = currencyAmount
        self.totalTaxes = totalTaxes        
    }
}

class ConvertedCurrencyModel {
    struct Keys {
        static let currency = "currency"
        static let amount = "amount"
    }
    
    var currency: String
    var amount: Double
    
    init?(json: [String: Any]) {
        guard let currency = json[Keys.currency] as? String,
            let amount = json[Keys.amount] as? String else { return nil }
        
        self.currency = currency
        self.amount = Double(amount)!
    }
}
