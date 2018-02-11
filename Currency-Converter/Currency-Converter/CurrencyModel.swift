//
//  CurrencyModel.swift
//  Currency-Converter
//
//  Created by Kristina Gelzinyte on 2/10/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

import Foundation

class CurrencyModel {
    var currency: String = "EUR"
    var currencyAmount: Double = 10000.0
    var totalTaxes: Double = 0.0
    var timesConverted: Int = 0
    
    init(_ currency: String, _ currencyAmount: Double, totalTaxes: Double, timesConverted: Int) {
        self.currency = currency
        self.currencyAmount = currencyAmount
        self.totalTaxes = totalTaxes
        self.timesConverted = timesConverted
    }
}

class ConvertedCurrencyModel {
    fileprivate enum Constants {
        enum Keys {
            static let currency = "currency"
            static let amount = "amount"
        }
    }
    
    var currency: String
    var amount: Double
    
    init?(json: [String: Any]) {
        guard let currency = json[Constants.Keys.currency] as? String,
            let amount = json[Constants.Keys.amount] as? String else { return nil }
        
        self.currency = currency
        self.amount = Double(amount)!
    }
}
