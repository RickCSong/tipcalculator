//
//  CalculatorViewController.swift
//  tips
//
//  Created by Rick Song on 12/25/15.
//  Copyright © 2015 Rick Song. All rights reserved.
//

import UIKit

extension Double {
    var asLocaleCurrency:String {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        formatter.locale = NSLocale.currentLocale()
        return formatter.stringFromNumber(self)!
    }
}

class CalculatorViewController: UIViewController {
    let defaults = NSUserDefaults.standardUserDefaults()
    
    @IBOutlet weak var calculationView: UIView!
    @IBOutlet weak var computationView: UIView!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // Set bill amount from persistance if last set < 10 minutes ago
        if let applicationLastActiveAt = defaults.objectForKey("application_last_active_at") as? NSDate {
            let billAmount = defaults.doubleForKey("default_bill_amount")
            
            if (NSDate().timeIntervalSinceDate(applicationLastActiveAt) > (10 * 60)) {
                defaults.removeObjectForKey("default_bill_amount")
                defaults.removeObjectForKey("default_bill_amount_set_at")
            } else {
                billField.text = String(format: "%.2f", billAmount)
            }
        }
        
        // Set default tip percentage
        let tipControlIndex = defaults.integerForKey("default_tip_control_index")
        tipControl.selectedSegmentIndex = tipControlIndex
        
        updateTotalAmount(0)
        billField.becomeFirstResponder()
    }
    
    override func viewWillDisappear(animated: Bool) {
        billField.resignFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func onBillFieldEditingChanged(sender: AnyObject) {
        updateTotalAmount()
    }
    
    @IBAction func onTipControlValueChanged(sender: AnyObject) {
        updateTotalAmount()
    }
    
    private func updateTotalAmount(animationDuration: Double = 0.4) {
        let tipPercentages = [0.18, 0.2, 0.22]
        let tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        
        if let billAmount = Double(billField.text!) {
            let tip = billAmount * tipPercentage
            let total = billAmount + tip
            
            // Store bill amount
            defaults.setDouble(billAmount, forKey: "default_bill_amount")
            defaults.synchronize()
            
            tipLabel.text = tip.asLocaleCurrency
            totalLabel.text = total.asLocaleCurrency
            
            UIView.animateWithDuration(animationDuration, animations: {
                self.computationView.alpha = 1
                self.computationView.transform = CGAffineTransformMakeTranslation(0, 0)
            })
        } else {
            tipLabel.text = (0.0).asLocaleCurrency
            totalLabel.text = (0.0).asLocaleCurrency
            
            UIView.animateWithDuration(animationDuration, animations: {
                self.computationView.alpha = 0
                self.computationView.transform = CGAffineTransformMakeTranslation(0, 250.0)
            })
        }
    }
}

