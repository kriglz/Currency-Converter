//
//  AccountSummaryTableViewCell.swift
//  Currency-Converter
//
//  Created by Kristina Gelzinyte on 2/10/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

import UIKit

class AccountSummaryTableViewCell: UITableViewCell {

    var currencyData: CurrencyModel? { didSet { updateUI() } }
    
    @IBOutlet weak var currencyType: UILabel!
    
    @IBOutlet weak var currencyTypeView: UIView!
    
    @IBOutlet weak var totalMoney: UILabel!
    
    private func updateUI() {
        guard let currencyData = currencyData else { return }
        currencyType.text = currencyData.currency
        totalMoney.text = currencyData.currencyAmount.setFloatingPointAndConvertToString()
    }
}

extension Double {
    func setFloatingPointAndConvertToString() -> String {
        return String(format: "%.2f", self)
    }
}
