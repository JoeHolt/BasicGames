//
//  Board.swift
//  Games
//
//  Created by Joe Holt on 1/28/16.
//  Copyright © 2016 Joe Holt Apps. All rights reserved.
//

import UIKit

class Board: NSObject {
    var width = Int()
    var height = Int()
    var boardArea: Int {
        return width * height
    }
    
    init(width: Int = 3, height: Int = 3) {
        super.init()
        self.width = width
        self.height = height
    }

}
