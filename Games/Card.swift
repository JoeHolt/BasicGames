//
//  Card.swift
//  Games
//
//  Created by Joe Holt on 1/18/16.
//  Copyright © 2016 Joe Holt Apps. All rights reserved.
//

import UIKit

class Card: NSObject {
    var contents = String()
    
    internal func march(_ otherCard: Card) -> Bool {
        if otherCard.contents == self.contents {
            return true
        } else {
            return false
        }
        
    }
}
