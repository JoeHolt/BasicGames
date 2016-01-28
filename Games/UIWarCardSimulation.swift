//
//  UICardButton.swift
//  Games
//
//  Created by Joe Holt on 1/25/16.
//  Copyright © 2016 Joe Holt Apps. All rights reserved.
//

import UIKit

class UIWarCardSimulation: UIButton {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        self.contentVerticalAlignment = UIControlContentVerticalAlignment.Top
        self.userInteractionEnabled = false
        self.layer.cornerRadius = 10.0
        self.layer.masksToBounds = true
    }

}
