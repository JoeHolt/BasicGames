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
    
    init(name: String, titleImage: UIImage, wins: Int) {
        self.name = name
        self.titleImage = titleImage
        self.wins = wins
    }
    
}
