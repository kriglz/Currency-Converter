//
//  ConverterViewController.swift
//  Currency-Converter
//
//  Created by Kristina Gelzinyte on 2/10/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

import UIKit

class ConverterViewController: UIViewController, UITextFieldDelegate {
    
    @IBAction func finish(_ sender: UIButton) {
        self.dismiss(animated: true) {
            // TODO - save values to uswr defaults.
            print("finish was hit")
        }
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        self.dismiss(animated: true) {
            // TODO - save values to uswr defaults.
            print("cancel was hit")
        }
    }
    
    @IBOutlet weak var input: UITextField!
    
    @IBOutlet weak var output: UITextField!
    
    private var inputAmount: Double? {
        return Double(input.text ?? "0")
    }
    
    private var outputAmount: Double?
    
    private var currencyFrom: String? { didSet { updateResult() } }

    private var currencyTo: String? { didSet { updateResult() } }

    @IBOutlet weak var fromEUR: UIButton!
    
    @IBOutlet weak var fromUSD: UIButton!
    
    @IBOutlet weak var fromJPY: UIButton!
    
    lazy var fromButtons: [UIButton] = [fromEUR, fromUSD, fromJPY]
    
    lazy var toButtons: [UIButton] = [toEUR, toUSD, toJPY]

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
    
    @IBOutlet weak var toEUR: UIButton!
    
    @IBOutlet weak var toUSD: UIButton!
    
    @IBOutlet weak var toJPY: UIButton!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func updateResult() {
        guard let currencyTo = currencyTo, let currencyFrom = currencyFrom  else {
            output.text = "ERROR. Please chose currencies."
            return
        }
        
        guard let inputAmount = inputAmount else {
            guard let input = input.text, !input.isEmpty else {
                output.text = "ERROR. Please use numbers."
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
                                    self.output.text = String(converted.amount)
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
    
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        updateResult()
//    }
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        updateResult()
//        return true
//    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        updateResult()
        return true
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
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
