//
//  TicTacToeGame.swift
//  Games
//
//  Created by Joe Holt on 1/28/16.
//  Copyright © 2016 Joe Holt Apps. All rights reserved.
//

import UIKit

class TicTacToeGame: NSObject {
    
    var currentPlayer: TicTacToePlayer!
    var waysToWin: [[Int]] {
        return populateWaysToWin()
    }
    var board: TicTacToeBoard!
    
    init(board: TicTacToeBoard) {
        self.board = board
    }
    
    internal func checkForWinner() -> BoardMarker? {
        //Finds winner using
        for wayToWin in waysToWin {
            let winner = board.equalityAtIndexs(wayToWin)
            if winner.areEqual {
                return winner.ofType
            }
        }
        return nil
    }
    
    internal func computerChooseLocation(computerPlayer: TicTacToePlayer) -> Int? {
        //Returns a space on the board and updates model board
        let randomInt = Int(arc4random_uniform(8))
        if !board.isFull {
            if board.markerForIndex(randomInt) != .N {
                board.setMarkerAtIndex(randomInt, markType: computerPlayer.marker)
                return randomInt
            }
        }
        return nil
    }
    
    private func populateWaysToWin() -> [[Int]] {
        //creates an array of values to be callde on checkForWinner
        //For three by three tic tac toe(Only version this app will handle)
        return [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]
    }

}
