//
//  GameScene.swift
//  SnakeAndLadder
//
//  Created by Denny Mathew on 08/04/19.
//  Copyright © 2019 Densigns. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    //Gameboard
    var board = SKSpriteNode()
    
    //Player Nodes
    var player = SKSpriteNode()
    var computer = SKSpriteNode()
    
    //Game State Variables
    var isPlayerTurn: Bool = true
    var isRolling: Bool = false
    var moveFinished: Bool = true
    var isGameOver: Bool = false
    
    //Player Positions
    var playerPosition: Int = 0
    var computerPosition: Int = 0
    
    //Player Labels
    var playerLabel = SKLabelNode()
    var computerLabel = SKLabelNode()
    var playerPositionLabel = SKLabelNode()
    var computerPositionLabel = SKLabelNode()
    
    //Game Sounds
    var diceSound = SKAction()
    var snakeSound = SKAction()
    var ladderSound = SKAction()
    var moveSound = SKAction()
    var introSound = SKAction()
    var lostSound = SKAction()
    var gameFlowSound = SKAction()
    
    //New Postions
    let snakePositions = [25: 3, 56: 48, 59: 1, 69:32, 83: 57, 91: 73, 94: 26, 99: 80]
    let ladderPositions = [7: 11, 20: 38, 28:65, 36: 44, 42: 63, 51: 67, 62: 81, 71: 90, 86: 97]
    
    //Z Positions
    enum ObjectZPosition: CGFloat {
        case board = 0
        case players = 1
        case labels = 2
        case dice = 3
    }
    
    override func didMove(to view: SKView) {
        self.backgroundColor = .black
        setupBoard()
        setupSounds()
    }
}

//MARK: - Setups
extension GameScene {
    
    private func setupBoard() {
        board = SKSpriteNode(imageNamed: "Gameboard")
        let height = self.frame.width / 2.2
        board.size = CGSize(width: height, height: height)
        board.zPosition = ObjectZPosition.board.rawValue
        addChild(board)
    }
    
    private func setupSounds() {
        diceSound = SKAction.playSoundFileNamed("Dice.mp3", waitForCompletion: false)
        snakeSound = SKAction.playSoundFileNamed("Snake.wav", waitForCompletion: false)
        ladderSound = SKAction.playSoundFileNamed("Ladder", waitForCompletion: false)
        moveSound = SKAction.playSoundFileNamed("Move.wav", waitForCompletion: false)
        lostSound = SKAction.playSoundFileNamed("Lost.wav", waitForCompletion: false)
        introSound = SKAction.playSoundFileNamed("Intro.wav", waitForCompletion: false)
        gameFlowSound = SKAction.playSoundFileNamed("Gameflow.wav", waitForCompletion: false)
    }
}
