//
//  WarGameVC.swift
//  Games
//
//  Created by Joe Holt on 1/19/16.
//  Copyright © 2016 Joe Holt Apps. All rights reserved.
//

import UIKit

class WarGameVC: UIViewController {

    @IBOutlet var cards: [UIButton]!
    @IBOutlet weak var BGView1: UIView!
    @IBOutlet weak var BGView2: UIView!
    @IBOutlet weak var BGView3: UIView!
    @IBOutlet weak var BGView4: UIView!
    @IBOutlet weak var Card0: UIButton! //Botton Left
    @IBOutlet weak var Card1: UIButton! //Top Left
    @IBOutlet weak var Card2: UIButton! //Top Right
    @IBOutlet weak var Card3: UIButton! //Bottom Right
    var BGViews = [UIView]()
    var players = [WarPlayer]()
    var deck = PlayingCardDeck()
    var game: WarGame!   //Initated Later
    var player1: WarPlayer! //User, Card Tag 0
    var computer1: WarPlayer! //Computer 1, Card Tag 1
    var computer2: WarPlayer! //Computer 2, Card Tag 2
    var computer3: WarPlayer! //Computer 3, Card Tag 3
    var timer = NSTimer()
    var idleTime = Double()
    var playedCards = [PlayingCard]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "War!"
        setUp()

    }
    
    @IBAction func player1ButtonTapped(sender: UIButton) {
        if player1.cardsLeft > 0 {
            flipCard(sender, player: player1)
            flipOpponentCards(){
                () in
                self.findWinner()
            }
        }
    }
    
    func flipOpponentCards(completion: () -> Void) {
        dispatch_after(secondsToDispatchTime(timeSeconds: idleTime), dispatch_get_main_queue()) {
            self.flipCard(self.Card1, player: self.computer1)
        }
        dispatch_after(secondsToDispatchTime(timeSeconds: (idleTime * 2)), dispatch_get_main_queue()) {
            self.flipCard(self.Card2, player: self.computer2)
        }
        dispatch_after(secondsToDispatchTime(timeSeconds: (idleTime * 3)), dispatch_get_main_queue()) {
            self.flipCard(self.Card3, player: self.computer3)
        }
        dispatch_after(secondsToDispatchTime(timeSeconds: (idleTime * 3.7)), dispatch_get_main_queue()) {
            completion()
        }
    }
    
    func setUp() {
        idleTime = 0.5
        createPlayersAndGame()
        setUpCards()
    }
    
    func flipCard(cardBTN: UIButton, player: WarPlayer) {
        let card = player.personalDeck.drawRandomCard()
        player.currentCard = card as! PlayingCard
        cardBTN.setBackgroundImage(UIImage(named: "CardFront"), forState: .Normal)
        cardBTN.setTitle(card.contents, forState: .Normal)
    }
    
    func findWinner() {
        //Finds winner and gives them the cards the won
        playedCards.appendContentsOf([player1.currentCard, computer1.currentCard,computer2.currentCard,computer3.currentCard])
        let higgestCard = game.highestCardValue(playedCards)
        let index = playedCards.indexOf(higgestCard[0])
        switch index! {
        case 0:
            player1.personalDeck.addCards(playedCards)
            updateUIForWinner(player1, cardBTN: Card0)
        case 1:
            computer1.personalDeck.addCards(playedCards)
            updateUIForWinner(computer1, cardBTN: Card1)
        case 2:
            computer2.personalDeck.addCards(playedCards)
            updateUIForWinner(computer2, cardBTN: Card2)
        case 3:
            computer3.personalDeck.addCards(playedCards)
            updateUIForWinner(computer3, cardBTN: Card3)
        default:
            print("Error")
        }
        playedCards.removeAll()
    }
    
    func updateUIForWinner(player: WarPlayer, cardBTN: UIButton) {
        //Updates UI to show winner
        UIView.animateWithDuration(idleTime/1.5, delay: 0.0, options: .CurveEaseIn, animations: {
            cardBTN.transform = CGAffineTransformMakeScale(1.1, 1.1)
            }, completion: { finished in
                UIView.animateWithDuration(self.idleTime/1.5, delay: 0.0, options: .CurveEaseOut, animations: {
                    cardBTN.transform = CGAffineTransformMakeScale(1.0, 1.0)
                    }, completion: { finished in
                        for card in self.cards {
                            card.setBackgroundImage(UIImage(named: "WarCard"), forState: .Normal)
                            card.setTitle("", forState: .Normal)
                        }
                })
            })
    }
    
    func createPlayersAndGame() {
        //Creates and initates the game and players
        player1 = WarPlayer(name: "Joe")
        computer1 = WarPlayer(name: "Computer Phill")
        computer2 = WarPlayer(name: "Computer Bill")
        computer3 = WarPlayer(name: "Computer Will")
        players = [player1, computer1, computer2, computer3]
        game = WarGame(players: players, deck: deck)
    }

    func setUpCards() {
        //Sets up cards with values not avlible in storyboard
        BGViews = [BGView1, BGView2, BGView3, BGView4]
        for card in cards {
            card.layer.cornerRadius = 12.0
            card.layer.masksToBounds = true
        }
        for view in BGViews {
            view.layer.borderColor = UIColor.blackColor().CGColor
            view.layer.borderWidth = 0.3
        }
    }


}
