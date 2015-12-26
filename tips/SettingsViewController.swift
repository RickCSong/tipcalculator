//
//  SettingsViewController.swift
//  tips
//
//  Created by Rick Song on 12/26/15.
//  Copyright © 2015 Rick Song. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    let defaults = NSUserDefaults.standardUserDefaults()
    
    @IBOutlet weak var defaultTipControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onDefaultTipControlValueChanged(sender: AnyObject) {
        let defaultTipPercentageIndex = defaultTipControl.selectedSegmentIndex
        defaults.setInteger(defaultTipPercentageIndex, forKey: "default_tip_control_index")
        defaults.synchronize()
    }
    
    @IBAction func dismissSettings(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
