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
    
    func addCard(card: Card, atTop: Bool) {
        if atTop {
            cards.insert(card, atIndex: 0)
        } else {
            cards.append(card)
        }
    }
    func addCard(card: Card) {
        cards.append(card)
    }
    func addCards(cards: [Card]) {
        for card in cards {
            addCard(card)
        }
    }
    
    func drawRandomCard() -> Card? {
        if cards.count > 0 {
            let rand = arc4random_uniform(UInt32(cards.count))
            let randomCard = cards[Int(rand)]
            cards.removeAtIndex(Int(rand))
            return randomCard
        } else {
            return nil
        }
    }   

}
