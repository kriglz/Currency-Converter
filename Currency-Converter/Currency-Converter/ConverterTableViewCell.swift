//
//  ConverterTableViewCell.swift
//  Currency-Converter
//
//  Created by Kristina Gelzinyte on 2/10/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

import UIKit

class ConverterTableViewCell: UITableViewCell {

    var currencyData: CurrencyModel? { didSet { updateUI() } }
    
    @IBOutlet weak var currencyType: UILabel!
    
    @IBOutlet weak var currencyTypeView: UIView!
    
    @IBOutlet weak var totalMoney: UILabel!
    
    private func updateUI() {
        
    }
    
    //    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

}
