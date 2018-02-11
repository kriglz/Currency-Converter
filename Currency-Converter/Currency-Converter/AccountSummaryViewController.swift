//
//  AccountSummaryViewController.swift
//  Currency-Converter
//
//  Created by Kristina Gelzinyte on 2/10/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

import UIKit

class AccountSummaryViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var currencyModels = [CurrencyModel]()
    
    private let currencyTypes = ["EUR", "USD", "JPY"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if currencyModels.isEmpty {
            let userDefaults = UserDefaults.standard
            if userDefaults.value(forKey: "EUR") == nil {
                userDefaults.set(1000.0, forKey: "EUR")
            }
            if userDefaults.value(forKey: "USD") == nil {
                userDefaults.set(0.0, forKey: "USD")
            }
            if userDefaults.value(forKey: "JPY") == nil {
                userDefaults.set(0.0, forKey: "JPY")
            }
            if userDefaults.value(forKey: "timesConverted") == nil {
                userDefaults.set(0, forKey: "timesConverted")
            }

            for currencyType in currencyTypes {
                let currencyAmount = userDefaults.value(forKey: currencyType) as? Double
                if let currencyAmount = currencyAmount {
                    let newCurrency = CurrencyModel.init(currencyType,
                                                         currencyAmount,
                                                         totalTaxes: 0.0)
                    currencyModels.append(newCurrency)
                }
            }
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationSegue = segue.destination as? ConverterViewController, segue.identifier == "convert" {
            destinationSegue.currentCurrencyModels = currencyModels
        }
    }
}

extension AccountSummaryViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencyModels.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "amount") as! AccountSummaryTableViewCell
        cell.currencyData = currencyModels[indexPath.row]
        return cell
    }
}
