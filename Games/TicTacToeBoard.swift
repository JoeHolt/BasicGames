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
    
    internal func randomEmptySpace() -> Int {
        var indexsOfEmptySpace = [Int]()
        var index = 0
        for space in board {
            if space == .N {
                indexsOfEmptySpace.append(index)
            }
            index++
        }
        return indexsOfEmptySpace.randomObject()!
    }
    
    internal func empty() {
        board.removeAll()
    }
    
    internal func restart() {
        board.removeAll()
        for _ in 0..<self.boardArea {
            board.append(.N)
        }
    }
    
    internal func equalityAtIndexs(indexs: [Int]) -> (Bool) {
        for i in indexs {
            if board[i] == .N {
                return false
            }
            if board[i] != board[indexs[0]] {
                //Not equal.
                return false
            }
        }
        //Equal
        print("equal")
        return (true)
    }
    
    internal func boardIsFull() -> Bool {
        if board.contains(.N) {
            return false
        } else {
            return true
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