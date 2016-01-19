//
//  ViewController.swift
//  Games
//
//  Created by Joe Holt on 1/18/16.
//  Copyright © 2016 Joe Holt Apps. All rights reserved.
//

import UIKit

class GameSelectVC: UITableViewController {

    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellHeading: UILabel!
    @IBOutlet weak var cellSubHeading: UILabel!
    
    var games = [Game]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let war = Game(name: "War", titleImage: UIImage(named: "WarIcon")!, wins: 0)
        games.append(war)
        
        var card = PlayingCard()
        card.suit = "♦︎"
        card.rank = "1"
        print(card.contents)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func setUp() {
        navigationController?.navigationBar.tintColor = UIColor.purpleColor()
        title = "Choose a Game!"
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

