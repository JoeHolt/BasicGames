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
                player.personalDeck.cards.append(deck.drawRandomCard()!)
            }
        }
    }
    func roundWinner(players: [WarPlayer]) -> [WarPlayer] {
        var currentHighestPlayer: [WarPlayer] = [players[0]]
        for player in players {
            if rankOfCard(player.currentCard) > rankOfCard(currentHighestPlayer[0].currentCard) {
                currentHighestPlayer.removeAll()
                currentHighestPlayer.append(player)
            } else if rankOfCard(player.currentCard) == rankOfCard(currentHighestPlayer[0].currentCard) {
                if player != players[0] {
                    //Because the intial highest card is the first in array, this fixes function thinking there is a war when there is not 
                    currentHighestPlayer.append(player)
                }
            }
        }
        return currentHighestPlayer
    }
    private func rankOfCard(card: PlayingCard) -> Int {
        //Higher the rank, better the card
        return PlayingCard.ranks.indexOf(card.rank)!
    }
    func checkForGameWinner(players: [WarPlayer]) -> WarPlayer? {
        var winners = [WarPlayer]()
        for player in players {
            if player.personalDeck.cards.count != 0 {
                //They continue on
                winners.append(player)
            }
        }
        if winners.count == 1 {
            return winners[0]
        } else {
            return nil
        }
    }

}
