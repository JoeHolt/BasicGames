//
//  WarDetailVC.swift
//  Games
//
//  Created by Joe Holt on 1/21/16.
//  Copyright © 2016 Joe Holt Apps. All rights reserved.
//

import UIKit

class WarDetailVC: UIViewController {
    var players = [WarPlayer]()
    var UICardViews = [UIView]()
    var hStackView = UIStackView()
    var winnerCards = [Card]()
    var faceDownUICards = [UIButton]()
    var width = CGFloat()
    var z: CGFloat = 0
    var lastAnimatedCard = UIButton()
    var cardsToShow = [UIButton]()
    let topCardY: CGFloat = 20
    var game: WarGame!
    var idleTime = 0.5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.setHidesBackButton(true, animated: true)
        createUI()
    }
    override func viewDidAppear(animated: Bool) {
        bringInCards()
        
    }
    
    func animateForWinner() {
        let winner = game.roundWinner(players)
        print(winner)
        if winner.count == 1 {
            cardExpandAM(winner[0])
        } else {
            //Double war
        }
        
        
    }
    
    func flipCards() {
        var i = 0
        for card in cardsToShow {
            let delay = (0.5 + Double(Double(i - 1) * 0.5))
            dispatch_after(GSDSeconds(seconds: delay), dispatch_get_main_queue(), {
                card.setImage(nil, forState: .Normal)
                card.setBackgroundImage(UIImage(named: "CardFront"), forState: .Normal)
            })
            i++
        }
    }
    
    func bringInCards() {
        var i = 0
        //Animation code isnt veru clean at all, fix later
        lastAnimatedCard = faceDownUICards[0]
        for card in faceDownUICards {
            let delay = (0.5 + Double(Double(i - 1) * 0.5))
            dispatch_after(GSDSeconds(seconds: delay), dispatch_get_main_queue(), {
                self.animateFaceDownCards(card)
                self.lastAnimatedCard = card
            })
            i++
        }
    }
    
    func animateFaceDownCards(card: UIButton) {
        if lastAnimatedCard.superview != card.superview {
            z = 0
        }
        UIView.animateWithDuration(1.0, delay: 0.0, options: .CurveEaseOut, animations: {
            card.center.y = (self.topCardY + 88 + (self.z * 50))
            }, completion: {
                Void in
                var a = [UIButton]()
                for i in self.faceDownUICards {
                    if i.center.y > 800 {
                        a.append(i)
                    }
                }
                if a.count == 0 {
                    self.flipCards()
                    self.animateForWinner()
                }
        })
        ++z
    }
    
    func createUI() {
        hStackView = UIStackView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height))
        hStackView.axis = UILayoutConstraintAxis.Horizontal
        hStackView.backgroundColor = UIColor.greenColor()
        hStackView.distribution = UIStackViewDistribution.FillEqually
        self.view.addSubview(hStackView)
        
        for player in players {
            //Create Views
            let cardView = UIView(frame: CGRect(x: 0, y: 0, width: (view.bounds.width/CGFloat(players.count)), height: view.bounds.height))
            cardView.backgroundColor = self.view.backgroundColor
            
            //Create Top Card Images
            width = (cardView.bounds.width - 40)
            let cardButton = UIButton(frame: CGRect(x: ((cardView.bounds.width - width)/2), y: topCardY, width: width, height: (width * 1.77)))
            cardButton.setBackgroundImage(UIImage(named: "CardFront"), forState: .Normal)
            let attrs = [NSFontAttributeName: UIFont.systemFontOfSize(20.0, weight: UIFontWeightLight)]
            let title = NSMutableAttributedString(string: player.currentCard.contents, attributes: attrs)
            title.addAttribute(NSForegroundColorAttributeName, value: UIColor.blackColor(), range: NSMakeRange(0, title.length))
            cardButton.setAttributedTitle(title, forState: .Normal)
            cardButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
            cardButton.contentVerticalAlignment = UIControlContentVerticalAlignment.Top
            cardButton.titleLabel?.textAlignment = .Center
            cardButton.layer.cornerRadius = 10.0
            cardButton.layer.masksToBounds = true
            cardButton.userInteractionEnabled = false
            cardView.addSubview(cardButton)
            hStackView.addArrangedSubview(cardView)
            
            //Makes cards
            for _ in 0..<3 {
                if player.personalDeck.cards.count > 1 {
                    //Player needs at least 1 card to have war
                    player.currentCard = player.personalDeck.drawRandomCard()! as! PlayingCard
                    winnerCards.append(player.currentCard)
                    let modelCard = player.personalDeck.drawRandomCard()!
                    let card = UIButton(frame: CGRect(x: ((cardView.bounds.width - width)/2), y: 1000, width: width, height: (width * 1.77)))
                    let attrs = [NSFontAttributeName: UIFont.systemFontOfSize(20.0, weight: UIFontWeightLight)]
                    let title = NSMutableAttributedString(string: modelCard.contents, attributes: attrs)
                    title.addAttribute(NSForegroundColorAttributeName, value: UIColor.blackColor(), range: NSMakeRange(0, title.length))
                    card.setAttributedTitle(title, forState: .Normal)
                    card.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
                    card.contentVerticalAlignment = UIControlContentVerticalAlignment.Top
                    card.setImage(UIImage(named: "WarCard"), forState: .Normal)
                    card.layer.cornerRadius = 10.0
                    card.layer.masksToBounds = true
                    card.userInteractionEnabled = false
                    winnerCards.append(modelCard)
                    cardView.addSubview(card)
                    faceDownUICards.append(card)
                }
            }
            let cardToShow = UIButton(frame: CGRect(x: ((cardView.bounds.width - width)/2), y: 1000, width: width, height: (width * 1.77)))
            player.currentCard = player.personalDeck.drawRandomCard()! as! PlayingCard
            cardToShow.setImage(UIImage(named: "WarCard"), forState: .Normal)
            cardToShow.layer.cornerRadius = 10.0
            cardToShow.layer.masksToBounds = true
            cardToShow.tag = 100 //Tag 100 = card to show
            let attrs2 = [NSFontAttributeName: UIFont.systemFontOfSize(20.0, weight: UIFontWeightLight)]
            let title2 = NSMutableAttributedString(string: player.currentCard.contents, attributes: attrs2)
            title.addAttribute(NSForegroundColorAttributeName, value: UIColor.blackColor(), range: NSMakeRange(0, title.length))
            cardToShow.setAttributedTitle(title2, forState: .Normal)
            cardToShow.setTitleColor(UIColor.clearColor(), forState: .Normal)
            player.currentCard = player.personalDeck.drawRandomCard()! as! PlayingCard
            player.UICard = cardToShow
            cardToShow.userInteractionEnabled = false
            winnerCards.append(player.currentCard)
            cardView.addSubview(cardToShow)
            faceDownUICards.append(cardToShow)
            cardsToShow.append(cardToShow)
        }
    }
    
    func cardExpandAM(player: WarPlayer) {
        //Updates UI to show winner
        UIView.animateWithDuration(idleTime/1.5, delay: 0.0, options: .CurveEaseIn, animations: {
            player.UICard.transform = CGAffineTransformMakeScale(1.1, 1.1)
            }, completion: { finished in
                UIView.animateWithDuration(self.idleTime/1.5, delay: 0.0, options: .CurveEaseOut, animations: {
                    player.UICard.transform = CGAffineTransformMakeScale(1.0, 1.0)
                    }, completion: nil)
        })
    }
    
}

/*
To do:
1.) Once winner is found flip all cards
2.) Animate to show winner
3.) Give all cards to a player
4.) Segue back
*/