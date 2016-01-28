//
//  SettingsDetailVC.swift
//  Games
//
//  Created by Joe Holt on 1/27/16.
//  Copyright © 2016 Joe Holt Apps. All rights reserved.
//

import UIKit

class SettingsDetailVC: UITableViewController {

    var cards = [String]()
    var defaults = NSUserDefaults.standardUserDefaults()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        cards = ["War Card", "Cloud Card"]
        
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cards.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cardCell", forIndexPath: indexPath)
        let cellLabel = cell.viewWithTag(2) as! UILabel //Label
        let cellImage = cell.viewWithTag(3) as! UIImageView //Image
        cellImage.image = UIImage(named: cards[indexPath.row].removeWhiteSpaces())
        cellImage.layer.cornerRadius = 18
        cellImage.layer.masksToBounds = true
        cellLabel.text = cards[indexPath.row]
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        defaults.setObject(cards[indexPath.row].removeWhiteSpaces(), forKey: "userCardString")
        navigationController?.popViewControllerAnimated(true)
    }
    
    

}
