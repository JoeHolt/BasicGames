//
//  TicTacToeBoard.swift
//  Games
//
//  Created by Joe Holt on 1/28/16.
//  Copyright © 2016 Joe Holt Apps. All rights reserved.
//

import UIKit

enum BoardMarker {
    case n //Nothing in space
    case x //X in space
    case o //0 in space
}

class TicTacToeBoard: Board {

    var board = [BoardMarker]()
    var isFull: Bool {
        return boardIsFull()
    }
    
    override init(width: Int, height: Int) {
        super.init(width: width, height: height)
        
        for _ in 0..<self.boardArea {
            board.append(.n)
        }
    }
    
    internal func markerForIndex(_ index: Int) -> BoardMarker {
        return board[index]
    }
    
    internal func setMarkerAtIndex(_ index: Int, markType: BoardMarker) {
        board[index] = markType
    }
    
    internal func removeMarkerAtIndex(_ index: Int) {
        board[index] = .n
    }
    
    internal func randomEmptySpace() -> Int {
        var indexsOfEmptySpace = [Int]()
        var index = 0
        for space in board {
            if space == .n {
                indexsOfEmptySpace.append(index)
            }
            index += 1
        }
        return indexsOfEmptySpace.randomObject()!
    }
    
    internal func empty() {
        board.removeAll()
    }
    
    internal func restart() {
        board.removeAll()
        for _ in 0..<self.boardArea {
            board.append(.n)
        }
    }
    
    internal func equalityAtIndexs(_ indexs: [Int]) -> (Bool) {
        for i in indexs {
            if board[i] == .n {
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
        if board.contains(.n) {
            return false
        } else {
            return true
        }
    }
    
    internal func stringForMarker(_ marker: BoardMarker) -> String {
        switch marker {
        case .o:
            return "O"
        case .x:
            return "X"
        case .n:
            return ""
        }
    }

}
