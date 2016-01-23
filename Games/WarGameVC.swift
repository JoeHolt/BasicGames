//
//  WarGameVC.swift
//  Games
//
//  Created by Joe Holt on 1/19/16.
//  Copyright © 2016 Joe Holt Apps. All rights reserved.
//

import UIKit

extension Array where Element: Equatable {
    //Simple function to remove object based on name
    mutating func removeObject(object : Generator.Element) {
        if let index = self.indexOf(object) {
            self.removeAtIndex(index)
        }
    }
}

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
    var game: WarGame!
    var player1: WarPlayer! //User, Card Tag 0
    var computer1: WarPlayer! //Computer 1, Card Tag 1
    var computer2: WarPlayer! //Computer 2, Card Tag 2
    var computer3: WarPlayer! //Computer 3, Card Tag 3
    var idleTime = Double()
    var playedCards = [PlayingCard]()
    var playersAtWar = [WarPlayer]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "War!"
        navigationItem.leftBarButtonItem?.title = ""
        setUp()

    }
    
    var a = 0
    @IBAction func player1ButtonTapped(sender: UIButton) {
        if a == 1 {
            performSegueWithIdentifier("warDetailSegue", sender: self)
        }
        a++
        if player1.cardsLeft > 0 {
            sender.userInteractionEnabled = false
            flipCardsUI(){
                () in
                self.findRoundWinner()  //Finds winner of wound
            }
        }
    }
    
    func flipCardsUI(completion: () -> Void) {
        for i in 0..<players.count {
            var delay = (idleTime + Double(Double(i - 1) * 0.5))
            if i == 0 { delay = 0 } //If it is the first card, flip imideataly
            dispatch_after(GSDSeconds(seconds: delay), dispatch_get_main_queue()) {
                self.flipCardHelper(self.players[i])
                if i == (self.players.count - 1) { completion() }
            }
        }
    }
    
    func setUp() {
        idleTime = 0.5
        createPlayersAndGame()
        setUpCards()
    }
    
    func flipCardHelper(player: WarPlayer) {
        if let card = player.personalDeck.drawRandomCard() {
            player.currentCard = card as! PlayingCard
            player.UICard.setBackgroundImage(UIImage(named: "CardFront"), forState: .Normal)
            player.UICard.setTitle(String(card.contents), forState: .Normal)
            print(card.contents)
        }
    }
    
    func findRoundWinner() {
        //Finds winner and gives them the cards the won
        for player in players {
            playedCards.append(player.currentCard)
        }
        let roundWinner: [WarPlayer] = game.roundWinner(players)
        if roundWinner.count == 1 {
            //One round winner
            roundWinner[0].personalDeck.addCards(playedCards)
            cardExpandAM(roundWinner[0])
        } else if roundWinner.count > 1 {
            //War
            playersAtWar = roundWinner
            performSegueWithIdentifier("warDetailSegue", sender: self)
            print("War initiated with players \(roundWinner)")
        } else {
            //Error
            print("findRoundWinner: Error")
        }
        
        playedCards.removeAll()
        checkForGameWinner()
    }
    
    func cardExpandAM(player: WarPlayer) {
        //Updates UI to show winner
        UIView.animateWithDuration(idleTime/1.5, delay: 0.0, options: .CurveEaseIn, animations: {
            player.UICard.transform = CGAffineTransformMakeScale(1.1, 1.1)
            }, completion: { finished in
                UIView.animateWithDuration(self.idleTime/1.5, delay: 0.0, options: .CurveEaseOut, animations: {
                    player.UICard.transform = CGAffineTransformMakeScale(1.0, 1.0)
                    }, completion: { finished in
                        for card in self.cards {
                            card.setBackgroundImage(UIImage(named: "WarCard"), forState: .Normal)
                            card.setTitle("", forState: .Normal)
                            self.Card0.userInteractionEnabled = true
                            for player in self.players {
                                if player.personalDeck.cards.count == 0 {
                                    player.UICard.hidden = true
                                    self.players.removeObject(player)
                                }
                            }
                        }
                })
            })
    }
    
    func checkForGameWinner() {
        for player in players {
            if player.personalDeck.cards.count == 0 {
                player.UICard.hidden = true
                
                //ADD ANIMATIONS FOR RE ARANGING CARDS AFTER ON IS REMOVED
                
                
            } else {
                if let winner = WarGame.checkForGameWinner(players) {
                    if winner == player1 {
                        let ac = UIAlertController(title: "You Win!", message: "You Won! You you like to play again?", preferredStyle: UIAlertControllerStyle.Alert)
                        ac.addAction(UIAlertAction(title: "Cancle", style: .Cancel, handler: nil))
                        ac.addAction(UIAlertAction(title: "Restart", style: .Default, handler: {
                            UIAlertAction in
                            self.restartGame()
                        }))
                        presentViewController(ac, animated: true, completion: nil)
                    } else {
                        let ac = UIAlertController(title: "You Lose!", message: "You lost! You you like to play again?", preferredStyle: UIAlertControllerStyle.Alert)
                        ac.addAction(UIAlertAction(title: "Cancle", style: .Cancel, handler: {
                            UIAlertAction in
                            self.Card0.userInteractionEnabled = false
                        }))
                        ac.addAction(UIAlertAction(title: "Restart", style: .Default, handler: {
                            UIAlertAction in
                            self.restartGame()
                        }))
                        presentViewController(ac, animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
    
    func createPlayersAndGame() {
        //Creates and initates the game and players
        player1 = WarPlayer(name: "Joe", UICard: Card0)
        computer1 = WarPlayer(name: "Computer Phill", UICard: Card1)
        computer2 = WarPlayer(name: "Computer Bill", UICard:  Card2)
        computer3 = WarPlayer(name: "Computer Will", UICard: Card3)
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
    
    func restartGame() {
        
    }

    override func prefersStatusBarHidden() -> Bool {
        return false
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "warDetailSegue" {
            let destinationVC = segue.destinationViewController as! WarDetailVC
            destinationVC.players = players //playersAtWar
            destinationVC.game = game
        }
    }

}

/* To Do:
1.) Make progran handle wars.
2.) Find way to show cards in each deck(Add number inbetween sword in deck)
3.) More animations(Card flip, and move cards when other decks are emtied)
4.) General bug fixes and UI enhancments
5.) New game screen icon
*/
