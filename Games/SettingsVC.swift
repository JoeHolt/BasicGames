//
//  SettingsVC.swift
//  Games
//
//  Created by Joe Holt on 1/25/16.
//  Copyright © 2016 Joe Holt Apps. All rights reserved.
//

import UIKit

class SettingsVC: UITableViewController, UITextFieldDelegate {

    @IBOutlet weak var warContentCard: UIView!
    @IBOutlet weak var warIdleTimeTV: UITextField!
    @IBOutlet weak var enableCardsLeftSW: UISwitch!
    @IBOutlet var nonSelectableCells: [UITableViewCell]!
    @IBOutlet var selectableCells: [UITableViewCell]!
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    @IBAction func warGameIdleTV(sender: UITextView) {
        if let number = Double(sender.text) {
            //String is a double
            defaults.setDouble(number, forKey: "warIdleTime")
        } else {
            //String is not double
            sender.text = ""
        }
        
    }
    
    @IBAction func warEnableCardsLeft(sender: UISwitch) {
        if sender.on {
            defaults.setBool(true, forKey: "enableCardsLeft")
        } else {
            defaults.setBool(false, forKey: "enableCardsLeft")
        }
    }
    
    func setUp() {
        warIdleTimeTV.placeholder = String(defaults.doubleForKey("warIdleTime"))
        self.warIdleTimeTV.delegate = self
        
        for cell in nonSelectableCells {
            cell.selectionStyle = UITableViewCellSelectionStyle.None
        }
        for cell in selectableCells {
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        }
        if defaults.boolForKey("enableCardsLeft") {
            enableCardsLeftSW.setOn(true, animated: true)
        } else {
            enableCardsLeftSW.setOn(false, animated: true)
        }
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    
    
    
}
