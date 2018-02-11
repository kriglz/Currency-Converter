//
//  ConverterViewController.swift
//  Currency-Converter
//
//  Created by Kristina Gelzinyte on 2/10/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

import UIKit

class ConverterViewController: UIViewController {
    
    @IBAction func finish(_ sender: UIButton) {
        self.dismiss(animated: true) {
            // TODO - save values to uswr defaults.
            print("button was hit")
        }
    }
    
    @IBOutlet weak var input: UITextField!
    
    @IBOutlet weak var output: UITextField!
    
    private var currencyFrom: String?

    private var currencyTo: String?

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
