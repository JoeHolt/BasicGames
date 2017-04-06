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
    var ticTacToe: Game!
    var settings: Game!
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initalLoad()
        war = Game(name: "War", titleImage: UIImage(named: "WarIcon")!, wins: defaults.integer(forKey: "WarWins"), segue: "warSegue")
        ticTacToe = Game(name: "Tic Tac Toe", titleImage: UIImage(named: "TicTacToeIcon")!, wins: defaults.integer(forKey: "TicTacToeWins"), segue: "ticTacToeSegue")
        settings = Game(name: "Settings", titleImage: UIImage(named: "GearIcon")!, wins: -1, segue: "settingsSegue")
        games.append(war)
        games.append(ticTacToe)
        games.append(settings)
        title = "Choose a Game"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        ticTacToe.wins = defaults.integer(forKey: "TicTacToeWins")
        war.wins = defaults.integer(forKey: "WarWins")
        tableView.reloadData()
    }
    
    func setUp() {
        navigationController?.navigationBar.tintColor = UIColor.purple
        title = "Choose a Game!"
    }
    
    func initalLoad() {
        let firstRun = UserDefaults.standard.bool(forKey: "firstRun") as Bool
        if !firstRun {
            //First Run
            defaults.set(0, forKey: "WarWins")
            defaults.set(0, forKey: "TicTacToeWins")
            defaults.set(0.5, forKey: "warIdleTime")
            defaults.set("Player 1", forKey: "ticPlayer1Name")
            defaults.set("Player 2", forKey: "ticPlayer2Name")
            defaults.set(0.5, forKey: "ticWaitTime")
            defaults.set("WarCard", forKey: "userCardString")
            defaults.set(true, forKey: "enableCardsLeft")
            defaults.set("Human Vs Computer", forKey: "ticGameType")
            defaults.set("Hard", forKey: "ticDif")
            UserDefaults.standard.set(true, forKey: "firstRun")
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "GameCell")!
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
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        games[indexPath.row].performSegue(self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    }


}

