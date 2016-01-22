//
//  PlayingCard.swift
//  Games
//
//  Created by Joe Holt on 1/18/16.
//  Copyright © 2016 Joe Holt Apps. All rights reserved.
//

import UIKit

class PlayingCard: Card {
    
    static var ranks = ["1","2","3","4","5","6","7","8","9","10","J","Q","K"]
    static var suits = ["♠️","♣️","♥️","♦️"]
    
    var rank = String() {
        didSet {
            if !PlayingCard.ranks.contains(rank) {
                rank = "ERROR"
                NSLog("Card ranks is not valid")
            }
        }
    }
    var suit = String() {
        didSet {
            if !PlayingCard.suits.contains(suit) {
                suit = "ERROR"
                NSLog("Card suit is not valid")
            }
        }
    }
    
    override var contents: String {
        get {
           return suit + rank
        }
        set {
           self.contents = newValue
        }
    }

}
