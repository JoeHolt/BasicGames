//
//  Game.swift
//  Games
//
//  Created by Joe Holt on 1/18/16.
//  Copyright © 2016 Joe Holt Apps. All rights reserved.
//

import UIKit

class Game: NSObject {
    var name = String()
    var titleImage = UIImage()
    var wins = Int()
    var segue = String()
    
    init(name: String, titleImage: UIImage, wins: Int, segue: String) {
        self.name = name
        self.titleImage = titleImage
        self.wins = wins
        self.segue = segue
    }
    
    internal func performSegue(_ sender: UITableViewController) {
        sender.performSegue(withIdentifier: segue, sender: sender)
    }
    
}
