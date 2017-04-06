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
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
        setUp()
    }
    
    @IBAction func warGameIdleTV(_ sender: UITextView) {
        if let number = Double(sender.text) {
            //String is a double
            defaults.set(number, forKey: "warIdleTime")
        } else {
            //String is not double
            sender.text = ""
        }
        
    }
    
    @IBAction func warEnableCardsLeft(_ sender: UISwitch) {
        if sender.isOn {
            defaults.set(true, forKey: "enableCardsLeft")
        } else {
            defaults.set(false, forKey: "enableCardsLeft")
        }
    }
    
    @IBAction func ticPlayer1NameTVDidFinish(_ sender: UITextField) {
        if sender.text == "" {
            defaults.set("Player 1", forKey: "ticPlayer1Name")
        } else {
            defaults.set(sender.text, forKey: "ticPlayer1Name")
        }
    }
    
    @IBAction func ticPlayer2NameTVDidFinish(_ sender: UITextField) {
        if sender.text == "" {
            defaults.set("Player 2", forKey: "ticPlayer2Name")
        } else {
            defaults.set(sender.text, forKey: "ticPlayer2Name")
        }
    }
    
    @IBAction func ticWaitTimeDidFinish(_ sender: UITextField) {
        if let number = Double(sender.text!) {
            //String is a double
            defaults.set(number, forKey: "ticWaitTime")
        } else {
            //String is not double
            sender.text = ""
        }
    }
    
    func setUp() {
        warIdleTimeTV.placeholder = String(defaults.double(forKey: "warIdleTime"))
        ticPlayer1Name.placeholder = defaults.object(forKey: "ticPlayer1Name") as? String
        ticPlayer2Name.placeholder = defaults.object(forKey: "ticPlayer2Name") as? String
        ticWaitTime.placeholder = String(defaults.double(forKey: "ticWaitTime"))
        self.warIdleTimeTV.delegate = self
        self.ticPlayer1Name.delegate = self
        self.ticPlayer2Name.delegate = self
        self.ticWaitTime.delegate = self
        
        for cell in nonSelectableCells {
            cell.selectionStyle = UITableViewCellSelectionStyle.none
        }
        for cell in selectableCells {
            cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        }
        if defaults.bool(forKey: "enableCardsLeft") {
            enableCardsLeftSW.setOn(true, animated: true)
        } else {
            enableCardsLeftSW.setOn(false, animated: true)
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! SettingsDetailVC
        switch (sender! as AnyObject).tag {
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
