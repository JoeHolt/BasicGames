//
//  SettingsDetailVC.swift
//  Games
//
//  Created by Joe Holt on 1/27/16.
//  Copyright © 2016 Joe Holt Apps. All rights reserved.
//

import UIKit

enum GameType {
    case HumanVsHuamn
    case HumanVsComputer
    case ComputerVsHuman
}

class SettingsDetailVC: UITableViewController {

    var cards = [String]()
    var gameTypes = [String]()
    var difficulties = [String]()
    var defaults = NSUserDefaults.standardUserDefaults()
    var displayType = String()
    var displayData = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        cards = ["War Card", "Cloud Card", "PacMan Card"]
        difficulties = ["Easy", "Hard"]
        gameTypes = ["Human vs Human", "Human vs Computer", "Computer vs Computer"]
        switch displayType {
        case "Cards":
            displayData = cards
        case "GameTypes":
            displayData = gameTypes
        case "Difficulty":
            displayData = difficulties
        default:
            print("Error in settingDetalVC")
        }
        
        title = "\(displayType)"
        
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayData.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch displayType {
        case "Cards":
            return setUpCellForCards(indexPath)
        case "GameTypes":
            return setUpCellBasic(gameTypes, indexPath: indexPath)
        case "Difficulty":
            return setUpCellBasic(difficulties, indexPath: indexPath)
        default:
            print("Error")
            return UITableViewCell()
        }
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch displayType {
        case "Cards":
            defaults.setObject(cards[indexPath.row].removeWhiteSpaces(), forKey: "userCardString")
        case "GameTypes":
            defaults.setObject(cards[indexPath.row].removeWhiteSpaces(), forKey: "ticGameType")
        case "Dif":
            defaults.setObject(cards[indexPath.row].removeWhiteSpaces(), forKey: "ticDif")
        default:
            print("Error")
        }
        navigationController?.popViewControllerAnimated(true)
    }
    
    func setUpCellBasic(data: [String], indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("basicCell", forIndexPath: indexPath)
        let cellLabel = cell.viewWithTag(1) as! UILabel //Label
        cellLabel.text = data[indexPath.row]
        return cell
    }
    
    func setUpCellForCards(indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cardCell", forIndexPath: indexPath)
        let cellLabel = cell.viewWithTag(2) as! UILabel //Label
        let cellImage = cell.viewWithTag(3) as! UIImageView //Image
        cellImage.image = UIImage(named: cards[indexPath.row].removeWhiteSpaces())
        cellImage.layer.cornerRadius = 18
        cellImage.layer.masksToBounds = true
        cellLabel.text = cards[indexPath.row]
        return cell
    }
    
    

}
