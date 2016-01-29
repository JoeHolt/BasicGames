//
//  TicTacToeBoard.swift
//  Games
//
//  Created by Joe Holt on 1/28/16.
//  Copyright © 2016 Joe Holt Apps. All rights reserved.
//

import UIKit

enum BoardMarker {
    case N //Nothing in space
    case X //X in space
    case O //0 in space
}

class TicTacToeBoard: Board {

    var board = [BoardMarker]()
    var isFull: Bool {
        return boardIsFull()
    }
    
    override init(width: Int, height: Int) {
        super.init(width: width, height: height)
        
        for _ in 0..<self.boardArea {
            board.append(.N)
        }
    }
    
    internal func markerForIndex(index: Int) -> BoardMarker {
        return board[index]
    }
    
    internal func setMarkerAtIndex(index: Int, markType: BoardMarker) {
        board[index] = markType
    }
    
    internal func removeMarkerAtIndex(index: Int) {
        board[index] = .N
    }
    
    internal func emptyBoard() {
        board.removeAll()
    }
    
    internal func equalityAtIndexs(indexs: [Int]) -> (areEqual: Bool, ofType: BoardMarker?) {
        for i in indexs {
            if i != indexs[0] {
                //Not equal.
                return (false, nil)
            }
        }
        //Equal
        return (true, board[indexs[0]])
    }
    
    internal func boardIsFull() -> Bool {
        var a = [BoardMarker]()
        for i in board {
            if i != .N { a.append(i) }
        }
        if a.count == board.count {
            return true
        } else {
            return false
        }
    }
    
    internal func stringForMarker(marker: BoardMarker) -> String {
        switch marker {
        case .O:
            return "O"
        case .X:
            return "X"
        case .N:
            return ""
        }
    }

}
