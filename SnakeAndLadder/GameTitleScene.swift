//
//  GameTitleScene.swift
//  SnakeAndLadder
//
//  Created by Denny Mathew on 09/04/19.
//  Copyright © 2019 Densigns. All rights reserved.
//

import UIKit
import SpriteKit

class GameTitleScene: SKScene {

    var introSound = SKAction()
    override func didMove(to view: SKView) {
        self.backgroundColor = .black
        setup()
    }
}

extension GameTitleScene {
    
    func setup() {
        
        let titleLabel = SKLabelNode(fontNamed: "DamascusBold")
        titleLabel.fontSize = 30
        titleLabel.fontColor = .white
        titleLabel.text = "Snakes & Ladders"
        titleLabel.position = CGPoint(x: 0, y: 70)
        addChild(titleLabel)
        
        let dice = SKSpriteNode(imageNamed: "Dice")
        dice.setScale(0.3)
        addChild(dice)
        
        let tapLabel = SKLabelNode(fontNamed: "DamascusLight")
        tapLabel.fontSize = 20
        tapLabel.fontColor = .white
        tapLabel.text = "Tap to play"
        tapLabel.position = CGPoint(x: 0, y: -70)
        addChild(tapLabel)
        
        tapLabel.run(SKAction.init(named: "Pulse")!) //FIXIT:- Not working
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let gameScene = GameScene(fileNamed: "GameScene")
        gameScene?.scaleMode = .aspectFill
        let transition = SKTransition.fade(withDuration: 1.0)
        self.view?.presentScene(gameScene!, transition: transition)
    }
}
