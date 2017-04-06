//
//  Deck.swift
//  Games
//
//  Created by Joe Holt on 1/18/16.
//  Copyright © 2016 Joe Holt Apps. All rights reserved.
//

import UIKit

class Deck: NSObject {
    var cards = [Card]()
    
    internal func addCard(_ card: Card, atTop: Bool) {
        if atTop {
            cards.insert(card, at: 0)
        } else {
            cards.append(card)
        }
    }
    internal func addCard(_ card: Card) {
        cards.append(card)
    }
    internal func addCards(_ cards: [Card]) {
        for card in cards {
            addCard(card)
        }
    }
    
    internal func drawRandomCard() -> Card? {
        if cards.count > 0 {
            let rand = arc4random_uniform(UInt32(cards.count))
            let randomCard = cards[Int(rand)]
            cards.remove(at: Int(rand))
            return randomCard
        } else {
            return nil
        }
    }   

}
