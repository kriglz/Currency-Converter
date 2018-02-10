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
    var currencyAmount: Float = 10000.0
    var totalTaxes: Float = 0.0
    var timesConverted: Int = 0
    
    init(_ currency: String, _ currencyAmount: Float, totalTaxes: Float, timesConverted: Int) {
        self.currency = currency
        self.currencyAmount = currencyAmount
        self.totalTaxes = totalTaxes
        self.timesConverted = timesConverted
    }
}
