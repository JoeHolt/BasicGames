//
//  WarDetailVC.swift
//  Games
//
//  Created by Joe Holt on 1/21/16.
//  Copyright © 2016 Joe Holt Apps. All rights reserved.
//

import UIKit

class WarDetailVC: UIViewController {
    var playersAtWar = [WarPlayer]()
    var UICardViews = [UIView]()
    var hStackView = UIStackView()
    var cards = [UIButton]()
    var faceDownUICards = [UIButton]()
    var width = CGFloat()
    var z: CGFloat = 0
    var lastAnimatedCard = UIButton()
    var cardsToShow = [UIButton]()
    var topCardY: CGFloat = 80
    var idleTime = 0.5
    var fontSize = CGFloat()
    var multiplier = CGFloat()
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        navigationItem.setHidesBackButton(true, animated: true)
        createUI()
        title = createTitleString()
    }
    override func viewDidAppear(_ animated: Bool) {
        bringInCards() {
            self.flipCards(self.cardsToShow, animate: true) {
                self.animateForWinner() {
                    self.flipCards(self.faceDownUICards, animate: false, completion: {
                        runAfterDelay(1.0, block: {
                            //self.performSegueWithIdentifier("warDetailToWar", sender: self)
                            self.navigationController?.popViewController(animated: true)
                        })
                    })
                }
            }
        }
    }
    func createTitleString() -> String {
        var string = ""
        for i in 0..<playersAtWar.count {
            if i == 0 {
                string = "\(playersAtWar[0].name)"
            } else {
                string = string + " vs \(playersAtWar[i].name)"
            }
        }
        return string
    }
    
    func animateForWinner(_ completion: @escaping () -> ()) {
        var winCards = [PlayingCard]()
        for player in playersAtWar {
            winCards.append(player.bottomWarCard)
        }
        var winner = roundWinner(playersAtWar)
        if winner.count == 1 {
            cardExpandAnimation(winner[0])
        } else {
            //Double war
            for player in playersAtWar {
                player.topWarCard = player.currentCard
            }
            viewDidLoad()
            viewDidAppear(true)
        }
        runAfterDelay((idleTime/0.5) * 2.1) {
            completion()
        }
    }
    
    func flipCards(_ cards: [UIButton], animate: Bool, completion: @escaping () -> ()) {
        var i = 0
        var delay = Double()
        for card in cards {
            delay = (0.5 + Double(Double(i - 1) * 0.5))
            runAfterDelay(delay) {
                if animate {
                UIView.transition(with: card, duration: 0.5, options: UIViewAnimationOptions.transitionFlipFromLeft, animations: {
                    card.setImage(nil, for: UIControlState())
                    card.layer.borderColor = UIColor.black.cgColor
                    card.layer.borderWidth = 0.5
                    card.setBackgroundImage(UIImage(named: "CardFront"), for: UIControlState())
                    self.faceDownUICards.removeObject(card)
                    }, completion: nil)
                } else {
                    card.setImage(nil, for: UIControlState())
                    card.layer.borderColor = UIColor.black.cgColor
                    card.layer.borderWidth = 0.5
                    card.setBackgroundImage(UIImage(named: "CardFront"), for: UIControlState())
                    self.faceDownUICards.removeObject(card)
                }
            }
            i += 1
        }
        runAfterDelay(delay + 1.7) {
            completion()
        }
    }
    
    func buttonToXY(_ button: UIButton, x: CGFloat, y: CGFloat) {
        UIView.animate(withDuration: 0.9, animations: {
            button.center.x = x
            button.center.y = y
        })
    }
    
    
    func bringInCards(_ completion: @escaping () -> ()) {
        var i = 0
        //Animation code isnt veru clean at all, fix later
        lastAnimatedCard = faceDownUICards[0]
        var delay = Double()
        for card in faceDownUICards {
            delay = (0.5 + Double(Double(i - 1) * 0.5))
            DispatchQueue.main.asyncAfter(deadline: GSDSeconds(seconds: delay), execute: {
                self.animateFaceDownCards(card)
                self.lastAnimatedCard = card
            })
            i += 1
        }
        runAfterDelay(delay + 0.5) {
            completion()
        }
    }
    
    func animateFaceDownCards(_ card: UIButton) {
        if lastAnimatedCard.superview != card.superview {
            z = 0
        }
        UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseOut, animations: {
            card.center.y = (self.topCardY + card.bounds.height/self.multiplier + (self.z * 50))
            }, completion: nil)
        z += 1
    }
    
    func createUI() {
        hStackView = UIStackView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height))
        hStackView.axis = UILayoutConstraintAxis.horizontal
        hStackView.backgroundColor = UIColor.green
        hStackView.distribution = UIStackViewDistribution.fillEqually
        self.view.addSubview(hStackView)
        
        for player in playersAtWar {
            //Create Views
            let cardView = UIView(frame: CGRect(x: 0, y: 0, width: (view.bounds.width/CGFloat(playersAtWar.count)), height: view.bounds.height))
            cardView.backgroundColor = self.view.backgroundColor
            
            //Create Top Card Images
            width = (cardView.bounds.width - 40)
            let cardButton = UIButton(frame: CGRect(x: ((cardView.bounds.width - width)/2), y: topCardY, width: width, height: (width * 1.77)))
            cardButton.setBackgroundImage(UIImage(named: "CardFront"), for: UIControlState())
            let attrs = [NSFontAttributeName: UIFont.systemFont(ofSize: fontSize, weight: UIFontWeightLight)]
            let title = NSMutableAttributedString(string: player.topWarCard.contents, attributes: attrs)
            title.addAttribute(NSForegroundColorAttributeName, value: UIColor.black, range: NSMakeRange(0, title.length))
            cardButton.setAttributedTitle(title, for: UIControlState())
            cardButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
            cardButton.contentVerticalAlignment = UIControlContentVerticalAlignment.top
            cardButton.layer.cornerRadius = 10.0
            cardButton.layer.masksToBounds = true
            cardButton.isUserInteractionEnabled = false
            cards.append(cardButton)
            cardView.addSubview(cardButton)
            hStackView.addArrangedSubview(cardView)
            
            //Makes cards
            for modelCard in player.faceDownWarCards {
                if player.personalDeck.cards.count > 1 {
                    //Player needs at least 1 card to have war
                    let card = UIButton(frame: CGRect(x: ((cardView.bounds.width - width)/2), y: 1000, width: width, height: (width * 1.77)))
                    let attrs = [NSFontAttributeName: UIFont.systemFont(ofSize: fontSize, weight: UIFontWeightLight)]
                    let title = NSMutableAttributedString(string: modelCard.contents, attributes: attrs)
                    title.addAttribute(NSForegroundColorAttributeName, value: UIColor.black, range: NSMakeRange(0, title.length))
                    card.setAttributedTitle(title, for: UIControlState())
                    card.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
                    card.contentVerticalAlignment = UIControlContentVerticalAlignment.top
                    if player.name == "You" {
                       card.setImage(getUserCardImage(), for: UIControlState())
                    } else {
                       card.setImage(UIImage(named: "WarCard"), for: UIControlState())
                    }
                    card.layer.cornerRadius = 10.0
                    card.layer.masksToBounds = true
                    card.isUserInteractionEnabled = false
                    cardView.addSubview(card)
                    faceDownUICards.append(card)
                    cards.append(card)
                }
            }
            let cardToShow = UIButton(frame: CGRect(x: ((cardView.bounds.width - width)/2), y: 1000, width: width, height: (width * 1.77)))
            if player.name == "You" {
                cardToShow.setImage(getUserCardImage(), for: UIControlState())
            } else {
                cardToShow.setImage(UIImage(named: "WarCard"), for: UIControlState())
            }
            cardToShow.layer.cornerRadius = 10.0
            cardToShow.layer.masksToBounds = true
            cardToShow.tag = 100 //Tag 100 = card to show
            let attrs2 = [NSFontAttributeName: UIFont.systemFont(ofSize: fontSize, weight: UIFontWeightLight)]
            let title2 = NSMutableAttributedString(string: player.bottomWarCard.contents, attributes: attrs2)
            title.addAttribute(NSForegroundColorAttributeName, value: UIColor.black, range: NSMakeRange(0, title.length))
            cardToShow.setAttributedTitle(title2, for: UIControlState())
            player.UICard = cardToShow
            cardToShow.isUserInteractionEnabled = false
            faceDownUICards.append(cardToShow)
            cardView.addSubview(cardToShow)
            cardsToShow.append(cardToShow)
            cards.append(cardToShow)
        }
    }
    
    func roundWinner(_ players: [WarPlayer]) -> [WarPlayer] {
        //Taken from WarGame.swift, dont have time to make this work nicely, FIX LATER
        var currentHighestPlayer: [WarPlayer] = [players[0]]
        for player in players {
            if PlayingCard.ranks.index(of: player.currentCard.rank)! > PlayingCard.ranks.index(of: currentHighestPlayer[0].currentCard.rank)! {
                currentHighestPlayer.removeAll()
                currentHighestPlayer.append(player)
            } else if PlayingCard.ranks.index(of: player.currentCard.rank)! == PlayingCard.ranks.index(of: currentHighestPlayer[0].currentCard.rank)! {
                if player != players[0] {
                    //Because the intial highest card is the first in array, this fixes function thinking there is a war when there is not
                    currentHighestPlayer.append(player)
                }
            }
        }
        return currentHighestPlayer
    }
    
    func cardExpandAnimation(_ player: WarPlayer) {
        //Updates UI to show winner
        UIView.animate(withDuration: idleTime/1.5, delay: 0.0, options: .curveEaseIn, animations: {
            player.UICard.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            }, completion: { finished in
                UIView.animate(withDuration: self.idleTime/1.5, delay: 0.0, options: .curveEaseOut, animations: {
                    player.UICard.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                    }, completion: nil)
        })
    }
    
    func getUserCardImage() -> UIImage {
        return UIImage(named: defaults.string(forKey: "userCardString")!)!
    }

    
    func setUp() {
        if playersAtWar.count == 4 {
            multiplier = 1.1
            fontSize = 20.0
        } else if playersAtWar.count == 2 {
            multiplier = 1.5
            fontSize = 40.0
        } else {
            multiplier = 1.24
            fontSize = 30.0
        }
    }

}

/*
To do:
Done for now :D
*/
