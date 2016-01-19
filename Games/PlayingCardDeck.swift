//
//  PlayingCardDeck.swift
//  Games
//
//  Created by Joe Holt on 1/18/16.
//  Copyright © 2016 Joe Holt Apps. All rights reserved.
//

import UIKit

class PlayingCardDeck: Deck {
    override init() {
        super.init()
        
        for rank in PlayingCard.ranks {
            for suit in PlayingCard.suits {
                let card = PlayingCard()
                card.rank = rank
                card.suit = suit
                self.addCard(card)
            }
        }
    }

}
