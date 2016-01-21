//
//  WarGame.swift
//  Games
//
//  Created by Joe Holt on 1/18/16.
//  Copyright © 2016 Joe Holt Apps. All rights reserved.
//

import UIKit
import Foundation

class WarGame: NSObject {
    var cardDeck = PlayingCardDeck()
    init(players: [WarPlayer], deck: Deck) {
        let cardsPerPlayer = deck.cards.count/players.count
        for player in players {
            for _ in 0..<cardsPerPlayer {
                player.personalDeck.cards.append(deck.drawRandomCard())
            }
        }
    }
    func highestCardValue(cards: [PlayingCard]) -> [PlayingCard] {
        var currentHighest = [cards[0]]
        for card in cards {
            if card.rank > currentHighest[0].rank {
                currentHighest.removeAll()
                currentHighest.append(card) //Clears array and adds highest value
            } else if card.rank == currentHighest[0].rank {
                currentHighest.append(card) //If there is 2 cards of highest rank both are returned
            }
        }
        return currentHighest
    }

}
