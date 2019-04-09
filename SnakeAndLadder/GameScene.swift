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
        
        startGame()
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
        human = SKSpriteNode(imageNamed: "Player1")
        let humanSize = board.size.width/20
        human.size = CGSize(width: humanSize, height: humanSize)
        human.position = CGPoint(x: leftX, y: humanPositionLabel.position.y - humanPositionLabel.frame.height/2 - 20 - human.size.height/2)
        human.zPosition = ObjectZPosition.players.rawValue
        human.alpha = 0.6
        addChild(human)
        
        //Computer Sprite Nodes
        computer = SKSpriteNode(imageNamed: "Player2")
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

//MARK: - Calculations
extension GameScene {
    
    func calculateMovePoint(_ position: CGFloat) -> CGPoint {
        
        let xStart = -board.frame.width/2
        let yStart = -board.frame.height/2
        let boxSize = board.size.width/10
        
        let row: Int = Int(ceil(position/10.0))
        var column: Int = 0
        
        if Int(position) % 10 == 0 {
            if (Int(position) / 10) % 2 == 0 {
                column = 1
            } else {
                column = 10
            }
        } else if row % 2 == 0 {
            column = 10 - Int(position) % 10 + 1
        } else {
            column = Int(position) % 10
        }
        
        let destinationX = xStart + boxSize/2 + (CGFloat(column - 1) * boxSize)
        let destinationY = yStart + boxSize/2 + (CGFloat(row - 1) * boxSize)
        
        return CGPoint(x: destinationX, y: destinationY)
    }
    
    func movePlayer(_ isHuman: Bool, position: CGFloat) {

        let newPoint = calculateMovePoint(position)
        let moveAction = SKAction.move(to: newPoint, duration: 1)
        
        if isHuman {
            self.human.run(moveAction) {
                self.humanPositionLabel.text = "\(self.humanPosition)"
                
                //Check for Ladder
                for key in self.ladderPositions.keys {
                    if key == Int(position) {
                        self.humanPosition = self.ladderPositions[key]!
                        self.movePlayer(true, position: CGFloat(self.humanPosition))
                        self.run(self.ladderSound)
                    }
                }
                
                //Check for Snake
                for key in self.snakePositions.keys {
                    if key == Int(position) {
                        self.humanPosition = self.snakePositions[key]!
                        self.movePlayer(true, position: CGFloat(self.humanPosition))
                        self.run(self.snakeSound)
                    }
                }
                
                self.moveFinished = true
                self.isHumanTurn = false
                self.flashTurn(false)
                self.checkWin()
                self.rollDice(false)
            }
        } else {
            self.computer.run(moveAction) {
                self.computerPositionLabel.text = "\(self.computerPosition)"
                
                //Check for Ladder
                for key in self.ladderPositions.keys {
                    if key == Int(position) {
                        self.computerPosition = self.ladderPositions[key]!
                        self.movePlayer(false, position: CGFloat(self.computerPosition))
                        self.run(self.ladderSound)
                    }
                }
                
                //Check for Snake
                for key in self.snakePositions.keys {
                    if key == Int(position) {
                        self.computerPosition = self.snakePositions[key]!
                        self.movePlayer(false, position: CGFloat(self.computerPosition))
                        self.run(self.snakeSound)
                    }
                }
                
                self.moveFinished = true
                self.isHumanTurn = true
                self.flashTurn(true)
                self.checkWin()
            }
        }
    }
}

//MARK: - Game Play
extension GameScene {
    
    func rollDice(_ isHuman: Bool) {
        
        if isGameOver || isRolling || !moveFinished {
            return
        }
        
        moveFinished = false
        isRolling = true
        
        self.run(self.diceSound)
        self.enumerateChildNodes(withName: "Dice") { (diceNode, stop) in
            diceNode.removeFromParent()
        }
        
        var diceTextures = [SKTexture]()
        
        for i in 0 ..< 10 {
            let random = GKRandomSource()
            let dice3d6 = GKGaussianDistribution(randomSource: random, lowestValue: 1, highestValue: 6)
            rolledDice = dice3d6.nextInt()
            
            let imageName = "dice_\(rolledDice)"
            let diceTexture = SKTexture(imageNamed: imageName)
            diceTextures.append(diceTexture)
        }
        
        let dice = SKSpriteNode(imageNamed: "dice_1")
        dice.name = "Dice"
        let width = board.size.width/9
        dice.size = CGSize(width: width, height: width)
        
        if isHuman {
            dice.position = CGPoint(x: leftX, y: 0)
        } else {
            dice.position = CGPoint(x: rightX, y: 0)
        }
        
        addChild(dice)
        
        //Animation
        let diceAnimation = SKAction.animate(with: diceTextures, timePerFrame: 0.2)
        dice.run(diceAnimation) {
            
            self.isRolling = false
            
            if isHuman {
                if self.humanPosition + self.rolledDice  <= 100 {
                    self.humanPosition += self.rolledDice
                    self.movePlayer(true, position: CGFloat(self.humanPosition))
                } else {
                    self.moveFinished = true
                    self.isHumanTurn = false
                    self.flashTurn(false)
                    self.rollDice(false)
                }
            } else {
                if self.computerPosition + self.rolledDice  <= 100 {
                    self.computerPosition += self.rolledDice
                    self.movePlayer(false, position: CGFloat(self.computerPosition))
                } else {
                    self.moveFinished = true
                    self.isHumanTurn = true
                    self.flashTurn(true)
                }
            }
        }
    }
    
    func flashTurn(_ isHuman: Bool) {
        
        if isHuman {
            computerLabel.removeAllActions()
            computerLabel.alpha = 1
            computerLabel.setScale(1)
            humanLabel.run(SKAction(named: "Pulse")!)
        } else {
            humanLabel.removeAllActions()
            humanLabel.alpha = 1
            humanLabel.setScale(1)
            computerLabel.run(SKAction(named: "Pulse")!)
        }
    }
    
    func startGame() {
        
        isHumanTurn = Int.random(in: 0...1000) % 2 == 0
        
        if !isHumanTurn {
            flashTurn(false)
            rollDice(false)
        } else {
            flashTurn(true)
        }
    }
    
    func checkWin() {
        
        if humanPosition == 100 {
            isGameOver = true
            displayWinLabel("You Won!")
            resetLabel()
        } else {
            displayWinLabel("You Lost!")
            resetLabel()
        }
    }
    
    func displayWinLabel(_ text: String) {
        
        let winLabel = SKLabelNode(fontNamed: "DiwanMishafi")
        winLabel.fontSize = 80
        winLabel.fontColor = .red
        winLabel.text = text
        winLabel.zPosition = ObjectZPosition.labels.rawValue
        winLabel.run(SKAction(named: "Pulse")!)
    }
    
    func resetLabel() {
        humanLabel.removeAllActions()
        humanLabel.alpha = 1
        humanLabel.setScale(1)
        
        computerLabel.removeAllActions()
        computerLabel.alpha = 1
        computerLabel.setScale(1)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if isHumanTurn && !isGameOver && !isRolling && moveFinished {
            rollDice(true)
        }
    }
}
