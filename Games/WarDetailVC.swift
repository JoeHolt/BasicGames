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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        players.append(WarPlayer(name: "J", UICard: UIButton()))
        players.append(WarPlayer(name: "k", UICard: UIButton()))
        navigationItem.setHidesBackButton(true, animated: true)
        createUI()
    }
    
    func createUI() {
        hStackView = UIStackView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height))
        hStackView.axis = UILayoutConstraintAxis.Horizontal
        hStackView.backgroundColor = UIColor.greenColor()
        hStackView.distribution = UIStackViewDistribution.FillEqually
        self.view.addSubview(hStackView)
        
        for player in players {
            print("a")
            
            //Create Views
            let cardView = UIView(frame: CGRect(x: 0, y: 0, width: (view.bounds.width/CGFloat(players.count)), height: view.bounds.height))
            cardView.backgroundColor = self.view.backgroundColor
            
            //Create Top Card Images
            let width = (cardView.bounds.width - 40)
            let cardButton = UIButton(frame: CGRect(x: ((cardView.bounds.width - width)/2), y: 20, width: width, height: (width * 1.77)))
            cardButton.setBackgroundImage(UIImage(named: "CardFront"), forState: .Normal)
            let attrs = [NSFontAttributeName: UIFont.systemFontOfSize(45.0, weight: UIFontWeightLight)]
            let title = NSMutableAttributedString(string: player.currentCard.contents, attributes: attrs)
            title.addAttribute(NSForegroundColorAttributeName, value: UIColor.blackColor(), range: NSMakeRange(0, title.length))
            cardButton.setAttributedTitle(title, forState: .Normal)
            cardButton.titleLabel?.textAlignment = .Center
            cardButton.layer.cornerRadius = 10.0
            cardButton.layer.masksToBounds = true
            cardView.addSubview(cardButton)
            hStackView.addArrangedSubview(cardView)

        }
    }
}

/*
To do:
1.) Create cards below view and have them animate up. 
2.) Flip win card 1 by one
3.) Give all cards to a player
4.) Segue back
*/