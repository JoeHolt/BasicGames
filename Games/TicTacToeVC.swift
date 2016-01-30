//
//  TicTacToeVC.swift
//  Games
//
//  Created by Joe Holt on 1/27/16.
//  Copyright © 2016 Joe Holt Apps. All rights reserved.
//

import UIKit

class TicTacToeVC: UIViewController {
    
    @IBOutlet weak var titleLBL: UILabel!
    @IBOutlet weak var scoreLBL1: UILabel!
    @IBOutlet weak var scoreLBL2: UILabel!
    @IBOutlet var boardButtons: [UIButton]!
    @IBOutlet weak var topViewTopLC: NSLayoutConstraint!
    var game: TicTacToeGame!
    let player1 = TicTacToePlayer(name: "Joe", markType: .X) //User
    let player2 = TicTacToePlayer(name: "Computer", markType: .O)
    var board: TicTacToeBoard!
    var delay = Double()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Tic Tac Toe"
        setUp()
        
    }
    
    @IBAction func boardButtonPressed(sender: UIButton) {
        print("Text \(sender.titleLabel?.text)")
        print(game.currentPlayer)
        if sender.titleLabel?.text == " " {
            if game.currentPlayer == player1 {
                setButtonTitleForMarker(sender, marker: player1.marker)
                board.setMarkerAtIndex(sender.tag, markType: player1.marker)
                sender.userInteractionEnabled = false
                game.currentPlayer = player2
                updateTopLabel()
                if !checkWinner() {
                    //Only run if there is no winner
                    runAfterDelay(0.5) {
                        self.computerMakeMove()
                    }
                }
                
            }
        }
        
    }
    
    @IBAction func titleDidSwipe(sender: AnyObject) {
        //Title Was Swipe... may not be need due to VC
    }
    
    private func computerMakeMove() {
        //Need to use tag because outlet collection is "unordered"
        let tag = game.computerMakeRandomMove(player2)
        setButtonTitleForMarkerWithTag(tag, marker: player2.marker)
        game.currentPlayer = player1
        updateTopLabel()
        checkWinner()
    }
    
    private func updateTopLabel() {
        titleLBL.text = "\(game.currentPlayer.name)'s Turn"
    }
    
    private func setButtonTitleForMarker(button: UIButton, marker: BoardMarker) {
        button.setTitle(board.stringForMarker(marker), forState: .Normal)
    }
    
    private func checkWinner() -> Bool {
        if (game.checkForWinner() != nil) {
            let winner = playerForMakrer(game.checkForWinner()!)
            winner.wins++
            if winner == player1 {
                setScoreLabel(scoreLBL1, player: winner, animated: true) {
                    self.restartGame()
                }
            } else {
                setScoreLabel(scoreLBL2, player: winner, animated: true) {
                    self.restartGame()
                }
            }
            return true
            //There is a winner
        } else {
            if board.isFull {
                //war
                self.restartGame()
                return false
            } else {
                return false
            }
        }
    }
    
    private func playerForMakrer(marker: BoardMarker) -> TicTacToePlayer {
        //Only set for two players as we will have no more than that
        if marker == player1.marker {
            return player1
        } else {
            return player2
        }
    }
    
    private func setScoreLabel(label: UILabel, player: TicTacToePlayer, animated: Bool, completion: () -> ()) {
        if animated == true {
            UIView.transitionWithView(label, duration: 0.75, options: UIViewAnimationOptions.TransitionFlipFromTop, animations: {
                label.text = "\(player.name): \(player.wins)"
                }, completion: {
                    (value: Bool) in
                    completion()
            })
        } else {
            label.text = "\(player.name): \(player.wins)"
        }
    }
    
    private func setButtonTitleForMarkerWithTag(tag: Int, marker: BoardMarker) {
        for button in boardButtons {
            if button.tag == tag {
                setButtonTitleForMarker(button, marker: marker)
                button.userInteractionEnabled = false
            }
        }
    }
    
    private func restartGame() {
        setUpButtons()
        game.currentPlayer = player1
        board.restart()
        updateTopLabel()
    }
    
    private func setUp() {
        //Sets constraint to acount for navigation bar
        topViewTopLC.constant = (navigationController?.navigationBar.frame.height)! + 20
        board = TicTacToeBoard(width: 3, height: 3)
        game = TicTacToeGame(board: board)
        game.currentPlayer = player1
        delay = 0.5
        setUpButtons()
        setUpLabels()
    }
    
    private func setUpLabels() {
        setScoreLabel(scoreLBL1, player: player1, animated: false, completion: {})
        setScoreLabel(scoreLBL2, player: player2, animated: false, completion: {})
        scoreLBL1.layer.backgroundColor = UIColor.whiteColor().CGColor
        scoreLBL2.layer.backgroundColor = UIColor.whiteColor().CGColor
        updateTopLabel()
    }
    
    private func setUpButtons() {
        for button in boardButtons {
            button.setTitle(" ", forState: .Normal)
            button.userInteractionEnabled = true
        }
    }
    
    
}
