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
    let defaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        initalLoad()
        super.viewDidLoad()
        let war = Game(name: "War", titleImage: UIImage(named: "WarIcon")!, wins: defaults.integerForKey("WarWins"))
        games.append(war)
        title = "Choose a Game"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func setUp() {
        navigationController?.navigationBar.tintColor = UIColor.purpleColor()
        title = "Choose a Game!"
    }
    
    func initalLoad() {
        let firstRun = NSUserDefaults.standardUserDefaults().boolForKey("firstRun") as Bool
        if !firstRun {
            defaults.setInteger(0, forKey: "WarWins")
            
            
            
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
        subTitle.text = "Wins: \(game.wins)"
        image.image = game.titleImage
        image.layer.cornerRadius = 8
        image.layer.masksToBounds = true
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0 {
            performSegueWithIdentifier("warSegue", sender: self)
        }
    }


}

