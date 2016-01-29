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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Tic Tac Toe"
        setUp()
        
    }
    
    @IBAction func boardButtonPressed(sender: UIButton) {
        if sender.titleLabel?.text == nil {
            if game.currentPlayer == player1 {
                setButtonTitleForMarker(sender, marker: player1.marker)
                sender.userInteractionEnabled = false
                game.currentPlayer = player2
                updateTopLabel()
            }
        }
        
    }
    
    @IBAction func titleDidSwipe(sender: AnyObject) {
        //Title Was Swipe... may not be need due to VC
    }
    
    private func updateTopLabel() {
        titleLBL.text = "\(game.currentPlayer.name)'s Turn"
    }
    
    private func setButtonTitleForMarker(button: UIButton, marker: BoardMarker) {
        button.setTitle(board.stringForMarker(marker), forState: .Normal)
    }
    
    private func setScoreLabel(label: UILabel, player: TicTacToePlayer) {
        label.text = "\(player.name): \(player.score)"
    }
    
    private func setUp() {
        //Sets constraint to acount for navigation bar
        topViewTopLC.constant = (navigationController?.navigationBar.frame.height)! + 20
        board = TicTacToeBoard(width: 3, height: 3)
        game = TicTacToeGame(board: board)
        game.currentPlayer = player1
        
        setUpButtonsAndLables()
    }
    
    private func setUpButtonsAndLables() {
        for button in boardButtons {
            button.setTitle("", forState: .Normal)
            button.userInteractionEnabled = true
        }
        setScoreLabel(scoreLBL1, player: player1)
        setScoreLabel(scoreLBL2, player: player2)
        updateTopLabel()
    }
    
    
}
