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
    @IBOutlet weak var ticPlayer1Name: UITextField!
    @IBOutlet weak var ticPlayer2Name: UITextField!
    @IBOutlet weak var ticWaitTime: UITextField!
    @IBOutlet var nonSelectableCells: [UITableViewCell]!
    @IBOutlet var selectableCells: [UITableViewCell]!
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
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
    
    @IBAction func ticPlayer1NameTVDidFinish(sender: UITextField) {
        if sender.text == "" {
            defaults.setObject("Player 1", forKey: "ticPlayer1Name")
        } else {
            defaults.setObject(sender.text, forKey: "ticPlayer1Name")
        }
    }
    
    @IBAction func ticPlayer2NameTVDidFinish(sender: UITextField) {
        if sender.text == "" {
            defaults.setObject("Player 2", forKey: "ticPlayer2Name")
        } else {
            defaults.setObject(sender.text, forKey: "ticPlayer2Name")
        }
    }
    
    @IBAction func ticWaitTimeDidFinish(sender: UITextField) {
        if let number = Double(sender.text!) {
            //String is a double
            defaults.setDouble(number, forKey: "ticWaitTime")
        } else {
            //String is not double
            sender.text = ""
        }
    }
    
    func setUp() {
        warIdleTimeTV.placeholder = String(defaults.doubleForKey("warIdleTime"))
        ticPlayer1Name.placeholder = defaults.objectForKey("ticPlayer1Name") as? String
        ticPlayer2Name.placeholder = defaults.objectForKey("ticPlayer2Name") as? String
        ticWaitTime.placeholder = String(defaults.doubleForKey("ticWaitTime"))
        self.warIdleTimeTV.delegate = self
        self.ticPlayer1Name.delegate = self
        self.ticPlayer2Name.delegate = self
        self.ticWaitTime.delegate = self
        
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destinationVC = segue.destinationViewController as! SettingsDetailVC
        switch sender!.tag {
        case 1: //warCard
            destinationVC.displayType = "Cards"
        case 2: //TicTacToe game wype
            destinationVC.displayType = "GameTypes"
        case 3:
            destinationVC.displayType = "Difficulty"
        default:
            print("Error")
        }
    }
    
    
    
    
}
