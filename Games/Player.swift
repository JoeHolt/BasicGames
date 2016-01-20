//
//  Player.swift
//  Games
//
//  Created by Joe Holt on 1/18/16.
//  Copyright © 2016 Joe Holt Apps. All rights reserved.
//

import UIKit

class Player: NSObject {
    var name = String()
    var color = UIColor()
    var cards = [Card]()
    var cardsLeft: Int {
        get {
            return cards.count
        }
        set {
            self.cardsLeft = newValue
        }
    }

}
