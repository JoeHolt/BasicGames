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
    @IBOutlet weak var boardView: UIView!
    @IBOutlet weak var topViewTopLC: NSLayoutConstraint!
    var game: TicTacToeGame!
    var player1: TicTacToePlayer! //User
    var player2: TicTacToePlayer!
    var board: TicTacToeBoard!
    var delay = Double()
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Tic Tac Toe"
        setUp()
        
    }
    
    @IBAction func boardButtonPressed(_ sender: UIButton) {
        print("Text \(sender.titleLabel?.text)")
        print(game.currentPlayer)
        if sender.titleLabel?.text == " " {
            if game.currentPlayer == player1 {
                setButtonTitleForMarker(sender, marker: player1.marker)
                board.setMarkerAtIndex(sender.tag, markType: player1.marker)
                sender.isUserInteractionEnabled = false
                game.currentPlayer = player2
                updateTopLabel()
                if !checkWinner() {
                    //Only run if there is no winner
                    runAfterDelay(delay) {
                        self.computerMakeMove()
                    }
                }
                
            }
        }
        
    }
    
    @IBAction func titleDidSwipe(_ sender: AnyObject) {
        //Title Was Swipe... may not be need due to VC
    }
    
    fileprivate func computerMakeMove() {
        //Need to use tag because outlet collection is "unordered"
        let tag = game.computerMakeRandomMove(player2)
        setButtonTitleForMarkerWithTag(tag, marker: player2.marker)
        game.currentPlayer = player1
        updateTopLabel()
        checkWinner()
    }
    
    fileprivate func updateTopLabel() {
        titleLBL.text = "\(game.currentPlayer.name)'s Turn"
    }
    
    fileprivate func setButtonTitleForMarker(_ button: UIButton, marker: BoardMarker) {
        button.setTitle(board.stringForMarker(marker), for: UIControlState())
    }
    
    fileprivate func checkWinner() -> Bool {
        if (game.checkForWinner() != nil) {
            let winner = playerForMakrer(game.checkForWinner()!)
            winner.wins += 1
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
    
    fileprivate func playerForMakrer(_ marker: BoardMarker) -> TicTacToePlayer {
        //Only set for two players as we will have no more than that
        if marker == player1.marker {
            return player1
        } else {
            return player2
        }
    }
    
    fileprivate func setScoreLabel(_ label: UILabel, player: TicTacToePlayer, animated: Bool, completion: @escaping () -> ()) {
        if animated == true {
            let oldColor = label.backgroundColor
            UIView.transition(with: label, duration: 0.75, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {
                label.backgroundColor = UIColor.green
                label.text = "\(player.name): \(player.wins)"
                }, completion: {
                    (value: Bool) in
                    UIView.transition(with: label, duration: 0.75, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {
                            label.backgroundColor = oldColor
                        }, completion: {
                            (value: Bool) in
                            completion()
                    })
            })
        } else {
            label.text = "\(player.name): \(player.wins)"
        }
    }
    
    fileprivate func setButtonTitleForMarkerWithTag(_ tag: Int, marker: BoardMarker) {
        for button in boardButtons {
            if button.tag == tag {
                setButtonTitleForMarker(button, marker: marker)
                button.isUserInteractionEnabled = false
            }
        }
    }
    
    fileprivate func restartGame() {
        setUpButtons()
        game.currentPlayer = player1
        board.restart()
        defaults.set((defaults.integer(forKey: "TicTacToeWins") + player1.wins), forKey: "TicTacToeWins")
        updateTopLabel()
        runAfterDelay(0.2) {
            self.transitionBoard()
        }
    }
    
    fileprivate func transitionBoard() {
        UIView.transition(with: boardView, duration: 1.0, options: UIViewAnimationOptions.transitionCurlDown, animations: {
            self.setUpButtons()
            }, completion: nil)
    }
    
    fileprivate func setUp() {
        //Sets constraint to acount for navigation bar
        topViewTopLC.constant = (navigationController?.navigationBar.frame.height)! + 20
        board = TicTacToeBoard(width: 3, height: 3)
        game = TicTacToeGame(board: board)
        player1 = TicTacToePlayer(name: (defaults.object(forKey: "ticPlayer1Name") as? String)!, markType: .x)
        player2 = TicTacToePlayer(name: (defaults.object(forKey: "ticPlayer2Name") as? String)!, markType: .o)
        game.currentPlayer = player1
        delay = defaults.double(forKey: "ticWaitTime")
        setUpButtons()
        setUpLabels()
    }
    
    fileprivate func setUpLabels() {
        setScoreLabel(scoreLBL1, player: player1, animated: false, completion: {})
        setScoreLabel(scoreLBL2, player: player2, animated: false, completion: {})
        scoreLBL1.layer.backgroundColor = UIColor.white.cgColor
        scoreLBL2.layer.backgroundColor = UIColor.white.cgColor
        updateTopLabel()
    }
    
    fileprivate func setUpButtons() {
        for button in boardButtons {
            button.setTitle(" ", for: UIControlState())
            button.isUserInteractionEnabled = true
        }
    }
    
    
}
