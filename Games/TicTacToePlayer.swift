//
//  TicTacToePlayer.swift
//  Games
//
//  Created by Joe Holt on 1/28/16.
//  Copyright © 2016 Joe Holt Apps. All rights reserved.
//

import UIKit

class TicTacToePlayer: Player {
    
    var marker: BoardMarker!
    var wins: Int = 0
    init(name: String, markType: BoardMarker) {
        super.init(name: name)
        self.marker = markType
    }
    
}
