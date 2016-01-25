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
    var faceDownWarCards = [Card]()
    var topWarCard = Card()
    var bottomWarCard = Card()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "War!"
        navigationController?.navigationItem.leftBarButtonItem?.title = ""
        navigationItem.leftBarButtonItem?.title = ""
        setUp()
    }
    
    @IBAction func player1ButtonTapped(sender: UIButton) {
        if player1.cardsLeft > 0 {
            print("s")
            for player in players {
                print(player.name)
            }
            print("e")
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
    
    
    
    func flipCardHelper(player: WarPlayer) {
        if let card = player.personalDeck.drawRandomCard() {
            print("Fliping: \(card.contents)")
            player.currentCard = card as! PlayingCard
            player.UICard.setBackgroundImage(UIImage(named: "CardFront"), forState: .Normal)
            player.UICard.setAttributedTitle(makeAtributtedTitle("\(card.contents)", fontSize: 70.0), forState: .Normal)
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
            cardExpandAnimation(roundWinner[0])
            playedCards.removeAll()
        } else if roundWinner.count > 1 {
            //War
            print("War initiated with players \(roundWinner)")
            for i in roundWinner {
                cardExpandAnimation(i)
            }
            //Find everything for war
            var warWinner = game.atWar(roundWinner)
            warWinner[0].personalDeck.addCards(playedCards)
            playedCards.removeAll()
            
            runAfterDelay((idleTime/1.5) * 2.1) {
                self.playersAtWar = roundWinner
                self.performSegueWithIdentifier("warDetailSegue", sender: self)
            }
            
        } else {
            //Error
            print("findRoundWinner: Error")
        }
        
        checkForGameWinner()
    }
    
    func cardExpandAnimation(player: WarPlayer) {
        //Updates UI to show winner
        UIView.animateWithDuration(idleTime/1.5, delay: 0.0, options: .CurveEaseIn, animations: {
            player.UICard.transform = CGAffineTransformMakeScale(1.1, 1.1)
            }, completion: { finished in
                UIView.animateWithDuration(self.idleTime/1.5, delay: 0.0, options: .CurveEaseOut, animations: {
                    player.UICard.transform = CGAffineTransformMakeScale(1.0, 1.0)
                    }, completion: { finished in
                        self.cardExpandFinished()
                })
            })
    }
    func cardExpandFinished() {
        for card in self.cards {
            card.setBackgroundImage(UIImage(named: "WarCard"), forState: .Normal)
            for player in self.players {
                player.UICard.setAttributedTitle(self.makeAtributtedTitle("\(player.personalDeck.cards.count)", fontSize: 20.0), forState: .Normal)
            }
            self.Card0.userInteractionEnabled = true
            for player in self.players {
                if player.personalDeck.cards.count == 0 {
                    self.players.removeObject(player)
                }
            }
        }
    }
    
    func checkForGameWinner() {
        for player in players {
            if player.personalDeck.cards.count == 0 {
                player.UICard.setImage(UIImage(named: "WarCard"), forState: .Normal)
                player.UICard.alpha = 0.5
            } else {
                if let winner = WarGame.checkForGameWinner(players) {
                    if winner == player1 {
                        NSUserDefaults.standardUserDefaults().setInteger((NSUserDefaults.standardUserDefaults().integerForKey("WarWins") + 1), forKey: "WarWins")
                        let ac = UIAlertController(title: "You Win!", message: "You Won! Would you like to play again?", preferredStyle: UIAlertControllerStyle.Alert)
                        ac.addAction(UIAlertAction(title: "No", style: .Cancel, handler: {
                            UIAlertAction in
                            self.navigationController?.popViewControllerAnimated(true)
                        }))
                        ac.addAction(UIAlertAction(title: "Yes", style: .Default, handler: {
                            UIAlertAction in
                            self.restartGame()
                        }))
                        presentViewController(ac, animated: true, completion: nil)
                    } else {
                        let ac = UIAlertController(title: "You Lose!", message: "You lost! You you like to play again?", preferredStyle: UIAlertControllerStyle.Alert)
                        ac.addAction(UIAlertAction(title: "No", style: .Cancel, handler: {
                            UIAlertAction in
                            self.navigationController?.popViewControllerAnimated(true)
                        }))
                        ac.addAction(UIAlertAction(title: "Yes", style: .Default, handler: {
                            UIAlertAction in
                            self.restartGame()
                        }))
                        presentViewController(ac, animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
    func setUp() {
        idleTime = 0.5
        if players.count == 0 {
            createPlayersAndGame()
        }
        setUpCards()
    }
    
    func createPlayersAndGame() {
        //Creates and initates the game and players
        player1 = WarPlayer(name: "Joe", UICard: Card0, tag: 0)
        computer1 = WarPlayer(name: "Computer Phill", UICard: Card1, tag: 1)
        computer2 = WarPlayer(name: "Computer Bill", UICard:  Card2, tag: 2)
        computer3 = WarPlayer(name: "Computer Will", UICard: Card3, tag: 3)
        
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
        for _ in BGViews {
            //view.layer.borderColor = UIColor.blackColor().CGColor
            //view.layer.borderWidth = 0.3
        }
        for player in players {
            player.UICard.setAttributedTitle(makeAtributtedTitle("\(player.personalDeck.cards.count)", fontSize: 20.0), forState: .Normal)
        }
    }
    
    func restartGame() {
        //Quick and dirty restart method, redo if cleaning code
        BGViews = [UIView]()
        players = [WarPlayer]()
        deck = PlayingCardDeck()
        idleTime = Double()
        playedCards = [PlayingCard]()
        playersAtWar = [WarPlayer]()
        viewDidLoad()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "warDetailSegue" {
            print("Segue Initiated")
            let destinationVC = segue.destinationViewController as! WarDetailVC
            destinationVC.playersAtWar = playersAtWar
            //playedCards.removeAll()
        }
    }
    func makeAtributtedTitle(text: String, fontSize: CGFloat) -> NSMutableAttributedString {
        let attrs = [NSFontAttributeName: UIFont.systemFontOfSize(fontSize, weight: UIFontWeightLight)]
        let title = NSMutableAttributedString(string: text, attributes: attrs)
        title.addAttribute(NSForegroundColorAttributeName, value: UIColor.blackColor(), range: NSMakeRange(0, title.length))
        return title
        
    }
}

/* To Do:
Done for now :D
*/
