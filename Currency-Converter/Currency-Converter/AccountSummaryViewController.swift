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
    
    private let currencyInitDefaults: [(type: String, amount: Double)] = [ ("EUR", 1000.0), ("USD", 0.0), ("JPY", 0.0)]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if currencyModels.isEmpty {
            let userDefaults = UserDefaults.standard
            if userDefaults.value(forKey: "dataModels") == nil {
                for currency in currencyInitDefaults {
                    let newCurrency = CurrencyModel.init(currency.type, currency.amount, totalTaxes: 0.0)
                    currencyModels.append(newCurrency)
                }
                try? userDefaults.set(PropertyListEncoder().encode(currencyModels), forKey: "dataModels")
                userDefaults.synchronize()
                
            } else {
                let encoded = userDefaults.object(forKey: "dataModels") as! Data
                guard let recoveredCurrencyModels = try? PropertyListDecoder().decode([CurrencyModel].self, from: encoded) else { return }
                currencyModels = recoveredCurrencyModels
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
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
