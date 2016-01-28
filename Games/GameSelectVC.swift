//
//  ViewController.swift
//  Games
//
//  Created by Joe Holt on 1/18/16.
//  Copyright © 2016 Joe Holt Apps. All rights reserved.
//

import UIKit

class GameSelectVC: UITableViewController {
    
    var games = [Game]()
    var war: Game!
    var settings: Game!
    let defaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        initalLoad()
        super.viewDidLoad()
        war = Game(name: "War", titleImage: UIImage(named: "WarIcon")!, wins: defaults.integerForKey("WarWins"), segue: "warSegue")
        settings = Game(name: "Settings", titleImage: UIImage(named: "GearIcon")!, wins: -1, segue: "settingsSegue")
        games.append(war)
        games.append(settings)
        title = "Choose a Game"
    }
    
    func setUp() {
        navigationController?.navigationBar.tintColor = UIColor.purpleColor()
        title = "Choose a Game!"
    }
    
    func initalLoad() {
        let firstRun = NSUserDefaults.standardUserDefaults().boolForKey("firstRun") as Bool
        if !firstRun {
            //First Run
            defaults.setInteger(0, forKey: "WarWins")
            defaults.setDouble(0.5, forKey: "warIdleTime")
            defaults.setObject("WarCard", forKey: "userCardString")
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "firstRun")
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("GameCell")!
        let game = games[indexPath.row]
        let titleLabel = cell.viewWithTag(2) as! UILabel //Title Label in Cell
        let subTitle = cell.viewWithTag(3) as! UILabel //Subheading in Cell
        let image = cell.viewWithTag(1) as! UIImageView //ImageView in Cell
        titleLabel.text = game.name
        if game.wins != -1 {
            subTitle.text = "Wins: \(game.wins)"
        } else {
            subTitle.text = "Settings for all games"
        }
        image.image = game.titleImage
        image.layer.cornerRadius = 8
        image.layer.masksToBounds = true
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        games[indexPath.row].performSegue(self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
    }


}

