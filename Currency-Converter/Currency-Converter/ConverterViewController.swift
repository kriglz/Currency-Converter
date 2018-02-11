//
//  ConverterViewController.swift
//  Currency-Converter
//
//  Created by Kristina Gelzinyte on 2/10/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

import UIKit

class ConverterViewController: UIViewController, UITextFieldDelegate {
    
    var currentCurrencyModels: [CurrencyModel]?
    
    private var inputAmount: Double? {
        return Double(input.text ?? "0")
    }
    
    private var currencyFrom: String? { didSet { updateResult() } }
    
    private var currencyTo: String? { didSet { updateResult() } }
    
    @IBOutlet weak var input: UITextField!
    
    @IBOutlet weak var output: UITextField!

    @IBOutlet weak var currentEUR: UILabel!
    
    @IBOutlet weak var currentUSD: UILabel!
    
    @IBOutlet weak var currentJPY: UILabel!
    
    @IBOutlet weak var taxes: UILabel!
    
    @IBOutlet weak var taxesCurrency: UILabel!
    
    lazy var fromButtons: [UIButton] = [fromEUR, fromUSD, fromJPY]
    
    lazy var toButtons: [UIButton] = [toEUR, toUSD, toJPY]
    
    @IBOutlet weak var fromEUR: UIButton!
    
    @IBOutlet weak var fromUSD: UIButton!
    
    @IBOutlet weak var fromJPY: UIButton!

    @IBOutlet weak var toEUR: UIButton!
    
    @IBOutlet weak var toUSD: UIButton!
    
    @IBOutlet weak var toJPY: UIButton!
    
    @IBAction func fromEUR(_ sender: UIButton) {
        sender.updateState(in: fromButtons)
        currencyFrom = sender.titleLabel?.text
    }
    
    @IBAction func fromUSD(_ sender: UIButton) {
        sender.updateState(in: fromButtons)
        currencyFrom = sender.titleLabel?.text
    }
    
    @IBAction func fromJPY(_ sender: UIButton) {
        sender.updateState(in: fromButtons)
        currencyFrom = sender.titleLabel?.text
    }
    
    @IBAction func toEUR(_ sender: UIButton) {
        sender.updateState(in: toButtons)
        currencyTo = sender.titleLabel?.text
    }
    
    @IBAction func toUSD(_ sender: UIButton) {
        sender.updateState(in: toButtons)
        currencyTo = sender.titleLabel?.text
    }
    
    @IBAction func toJPY(_ sender: UIButton) {
        sender.updateState(in: toButtons)
        currencyTo = sender.titleLabel?.text
    }
    
    private var canBeConverted: Bool = false
    
    @IBAction func finish(_ sender: UIButton) {
        if canBeConverted {
            let userDefaults = UserDefaults.standard
            if let userDefaultsTimesConverted = userDefaults.value(forKey: "timesConverted") as? Int {
                userDefaults.setValue(userDefaultsTimesConverted + 1, forKey: "timesConverted")
            }
            
            if let currentCurrencyModels = currentCurrencyModels {
                for currentCurrencyModel in currentCurrencyModels {
                    if currencyFrom == currentCurrencyModel.currency, let input = input.text, let inputAmount = Double(input), let taxes = taxes.text, let taxesAmount = Double(taxes) {
                        currentCurrencyModel.currencyAmount -= (inputAmount + taxesAmount)
                        currentCurrencyModel.totalTaxes += taxesAmount
                    }
                    
                    if currencyTo == currentCurrencyModel.currency, let output = output.text, let outputAmount = Double(output) {
                        currentCurrencyModel.currencyAmount += outputAmount
                    }
                }
            }
            self.dismiss(animated: true)
            
        } else {
            let alert = UIAlertController(title: "Operation has failed", message: "Please enter valid operation to proceed.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateCurrencyAmount()
    }
    
    private func updateCurrencyAmount() {
        if let currentCurrencyModels = currentCurrencyModels {
            for currentCurrencyModel in currentCurrencyModels {
                switch currentCurrencyModel.currency {
                case "EUR":
                    currentEUR.text = "\(currentCurrencyModel.currencyAmount) EUR"
                case "USD":
                    currentUSD.text = "\(currentCurrencyModel.currencyAmount) USD"
                case "JPY":
                    currentJPY.text = "\(currentCurrencyModel.currencyAmount) JPY"
                default:
                    break
                }
            }
        }
    }
    
    private func updateResult() {
        guard let currencyTo = currencyTo, let currencyFrom = currencyFrom  else {
            output.text = "Error - Please choose currencies."
            return
        }
        
        guard let inputAmount = inputAmount else {
            guard let input = input.text, !input.isEmpty else {
                output.text = "Error - Please use numbers."
                return
            }
            return
        }
        
        let urlString = URL(string: "http://api.evp.lt/currency/commercial/exchange/\(inputAmount)-\(currencyFrom)/\(currencyTo)/latest")
        if let url = urlString {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    if let data = data {
                        do {
                            let object = try JSONSerialization.jsonObject(with: data) as! [String: Any]
                            if let converted = ConvertedCurrencyModel(json: object) {
                                DispatchQueue.main.async {
                                    let conversionTaxesAmount = self.conversionTaxes(for: inputAmount)
                                    self.taxes.text = "\(conversionTaxesAmount)"
                                    self.taxesCurrency.text = "\(currencyFrom)"
                                    
                                    if let currentCurrencyModels = self.currentCurrencyModels {
                                        for currentCurrencyModel in currentCurrencyModels {
                                            if currencyFrom == currentCurrencyModel.currency {
                                                let totalAmount = inputAmount + conversionTaxesAmount
                                                if currentCurrencyModel.currencyAmount >= totalAmount {
                                                    self.output.text = String(converted.amount)
                                                    self.canBeConverted = true
                                                } else {
                                                    self.output.text = "Exceeding your account money."
                                                    self.canBeConverted = false
                                                }
                                            }
                                        }
                                    }
                                }
                            } else {
                                print("Failed to make a model.")
                            }
                        } catch {
                            print("json error: \(error.localizedDescription)")
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    private func conversionTaxes(for convertedAmount: Double) -> Double {
        let userDefaults = UserDefaults.standard
        guard let userDefaultsTimesConverted = userDefaults.value(forKey: "timesConverted") as? Int else {
            return convertedAmount * conversionTaxesRate
        }
        if userDefaultsTimesConverted < 5 {
            return 0
        } else {
            return convertedAmount * conversionTaxesRate
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        output.text = nil
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        updateResult()
        return true
    }
}

extension UIButton {
    func updateState(in buttonStack: [UIButton]) {
        self.backgroundColor = UIColor(red: 232/255, green: 183/255, blue: 180/255, alpha: 1.0)
        for button in buttonStack {
            if button != self {
                button.backgroundColor = UIColor(red: 173/255, green: 173/255, blue: 173/255, alpha: 1.0)
            }
        }
    }
}
