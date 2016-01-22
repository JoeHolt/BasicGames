//
//  WarPlayer.swift
//  Games
//
//  Created by Joe Holt on 1/20/16.
//  Copyright © 2016 Joe Holt Apps. All rights reserved.
//

import UIKit

class WarPlayer: Player {
    var personalDeck = Deck()
    var cardsLeft: Int {
        get {
            return personalDeck.cards.count
        }
        set {
            self.cardsLeft = newValue
        }
    }
    var currentCard = PlayingCard()
    var UICard = UIButton()
    
    init(name: String, UICard: UIButton) {
        super.init(name: name)
        self.UICard = UICard
    }
}
