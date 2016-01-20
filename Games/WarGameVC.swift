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
    var BGViews = [UIView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "War!"
        setUp()
        
    }
    
    func setUp() {
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
