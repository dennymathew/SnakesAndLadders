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
    var human = SKSpriteNode()
    var computer = SKSpriteNode()
    
    //Game State Variables
    var isHumanTurn: Bool = true
    var isRolling: Bool = false
    var moveFinished: Bool = true
    var isGameOver: Bool = false
    
    //Player Positions
    var humanPosition: Int = 0
    var computerPosition: Int = 0
    
    //Player Labels
    var humanLabel = SKLabelNode()
    var computerLabel = SKLabelNode()
    var humanPositionLabel = SKLabelNode()
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
    
    //X Positions
    var leftX: CGFloat = 0.0
    var rightX: CGFloat = 0.0
    
    //Rolled Dice
    var rolledDice: Int = 0
    
    
    override func didMove(to view: SKView) {
        self.backgroundColor = .black
        setupBoard()
        setupSounds()
        setupPlayers()
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
    
    fileprivate func setupPlayerLabels() {
        //Player Labels
        humanLabel = SKLabelNode(fontNamed: "Courier")
        humanLabel.fontSize = 20
        humanLabel.fontColor = .white
        humanLabel.text = "You"
        
        leftX = -board.size.width/2 - (self.frame.width - board.size.width)/4
        let leftY = board.size.height/2 - humanLabel.frame.height - 20
        rightX = board.size.width/2 + (self.frame.width - board.size.width)/4
        
        humanLabel.position = CGPoint(x: leftX, y: leftY)
        humanLabel.zPosition = ObjectZPosition.labels.rawValue
        addChild(humanLabel)
        
        computerLabel = SKLabelNode(fontNamed: "Courier")
        computerLabel.fontSize = 20
        computerLabel.fontColor = .white
        computerLabel.text = "Computer"
        
        computerLabel.position = CGPoint(x: rightX, y: leftY)
        computerLabel.zPosition = ObjectZPosition.labels.rawValue
        addChild(computerLabel)
    }
    
    fileprivate func setupPositionLabels() {
        
        //Human Position Labels
        humanPositionLabel = SKLabelNode(fontNamed: "Courier")
        humanPositionLabel.fontSize = 25
        humanPositionLabel.fontColor = .lightGray
        humanPositionLabel.text = "\(humanPosition)"
        
        humanPositionLabel.position = CGPoint(x: leftX, y: humanLabel.position.y - humanLabel.frame.height - 20)
        humanPositionLabel.zPosition = ObjectZPosition.labels.rawValue
        addChild(humanPositionLabel)
        
        //Computer Position Labels
        computerPositionLabel = SKLabelNode(fontNamed: "Courier")
        computerPositionLabel.fontSize = 25
        computerPositionLabel.fontColor = .lightGray
        computerPositionLabel.text = "\(computerPosition)"
        
        computerPositionLabel.position = CGPoint(x: rightX, y: computerLabel.position.y - computerLabel.frame.height - 20)
        computerPositionLabel.zPosition = ObjectZPosition.labels.rawValue
        addChild(computerPositionLabel)
    }
    
    fileprivate func setupPlayerNodes() {
        
        //Human Sprite Nodes
        let human = SKSpriteNode(imageNamed: "Player1")
        let humanSize = board.size.width/20
        human.size = CGSize(width: humanSize, height: humanSize)
        human.position = CGPoint(x: leftX, y: humanPositionLabel.position.y - humanPositionLabel.frame.height/2 - 20 - human.size.height/2)
        human.zPosition = ObjectZPosition.players.rawValue
        human.alpha = 0.6
        addChild(human)
        
        //Computer Sprite Nodes
        let computer = SKSpriteNode(imageNamed: "Player2")
        let computerSize = board.size.width/20
        computer.size = CGSize(width: computerSize, height: computerSize)
        computer.position = CGPoint(x: rightX, y: computerPositionLabel.position.y - computerPositionLabel.frame.height/2 - 20 - computer.size.height/2)
        computer.zPosition = ObjectZPosition.players.rawValue
        computer.alpha = 0.6
        addChild(computer)
    }
    
    private func setupPlayers() {
        
        setupPlayerLabels()
        setupPositionLabels()
        setupPlayerNodes()
    }
}
