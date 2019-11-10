//
//  MainMenuScene.swift
//  Free Fall
//
//  Created by Jason Cardinale on 11/4/18.
//  Copyright © 2018 Jason Cardinale. All rights reserved.
//

import Foundation
import SpriteKit

class MainMenuScene: SKScene {
    
    let startGame = SKLabelNode(fontNamed: "Comfortaa-Bold")
    
    override func didMove(to view: SKView) {
        
        let background = SKSpriteNode(imageNamed: "background_gradient")
        background.size = self.size
        background.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.5)
        background.zPosition = 0
        self.addChild(background)
        
        let nameTop = SKLabelNode(fontNamed: "Comfortaa-Bold")
        nameTop.text = "Free"
        nameTop.fontSize = 200
        nameTop.fontColor = SKColor.white
        nameTop.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.8)
        nameTop.zPosition = 2
        self.addChild(nameTop)
        
        let nameBot = SKLabelNode(fontNamed: "Comfortaa-Bold")
        nameBot.text = "Fall"
        nameBot.fontSize = 200
        nameBot.fontColor = SKColor.white
        nameBot.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.7)
        nameBot.zPosition = 2
        self.addChild(nameBot)
        
        let leftLine = SKShapeNode()
        leftLine.path = UIBezierPath(roundedRect: CGRect(x: -128, y: -128, width: 50, height: 200), cornerRadius: 50).cgPath
        leftLine.position = CGPoint(x: self.size.width*0.5, y: self.size.height + 200)
        leftLine.fillColor = UIColor.white
        leftLine.zPosition = 1;
        self.addChild(leftLine)
        
        let midLine = SKShapeNode()
        midLine.path = UIBezierPath(roundedRect: CGRect(x: -128, y: -128, width: 50, height: 250), cornerRadius: 50).cgPath
        midLine.position = CGPoint(x: self.size.width*0.57, y: self.size.height + 250)
        midLine.fillColor = UIColor.white
        midLine.zPosition = 1;
        self.addChild(midLine)
        
        let rightLine = SKShapeNode()
        rightLine.path = UIBezierPath(roundedRect: CGRect(x: -128, y: -128, width: 50, height: 150), cornerRadius: 50).cgPath
        rightLine.position = CGPoint(x: self.size.width*0.63, y: self.size.height + 150)
        rightLine.fillColor = UIColor.white
        rightLine.zPosition = 1;
        self.addChild(rightLine)
        
        let circle = SKShapeNode()
        circle.path = UIBezierPath(ovalIn: CGRect(x: -128, y: -128, width: 256, height: 256)).cgPath
        circle.position = CGPoint(x: self.size.width*0.5, y: self.size.height + 256)
        circle.fillColor = UIColor.white
        circle.zPosition = 1;
        self.addChild(circle)
        
        let ballFallDown = SKAction.moveTo(y: self.size.height*0.4, duration: 0.5)
        let ballBounceUp = SKAction.moveTo(y: self.size.height*0.45, duration: 0.1)
        let ballBounceDown = SKAction.moveTo(y: self.size.height*0.4, duration: 0.1)
        let moveToScreenSequence = SKAction.sequence([ballFallDown, ballBounceUp, ballBounceDown])
        
        let leftFallDown = SKAction.moveTo(y: self.size.height*0.53, duration: 0.5)
        let midFallDown = SKAction.moveTo(y: self.size.height*0.56, duration: 0.5)
        let rightFallDown = SKAction.moveTo(y: self.size.height*0.53, duration: 0.5)
        let pause = SKAction.wait(forDuration: 0.25)
        
        let leftSequence = SKAction.sequence([pause, leftFallDown])
        let midSequence = SKAction.sequence([pause, pause, midFallDown])
        let rightSequence = SKAction.sequence([pause, pause, pause, rightFallDown])
        
        circle.run(moveToScreenSequence)
        leftLine.run(leftSequence)
        midLine.run(midSequence)
        rightLine.run(rightSequence)
        
        
        startGame.text = "Start"
        startGame.fontSize = 150
        startGame.fontColor = SKColor.white
        startGame.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.2)
        startGame.zPosition = 1
        startGame.name = "Start"
        self.addChild(startGame)
        
        let textFadeOut = SKAction.fadeOut(withDuration: 0)
        let textFadeIn = SKAction.fadeIn(withDuration: 2)
        nameTop.run(textFadeOut)
        nameBot.run(textFadeOut)
        startGame.run(textFadeOut)
        
        nameTop.run(textFadeIn)
        nameBot.run(textFadeIn)
        startGame.run(textFadeIn)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch: AnyObject in touches {
            
            let pointOfTouch = touch.location(in: self)
            
            if startGame.contains(pointOfTouch) {
                
                let sceneToMoveTo = GameScene(size: self.size)
                sceneToMoveTo.scaleMode = self.scaleMode
                let myTransition = SKTransition.fade(withDuration: 1)
                self.view!.presentScene(sceneToMoveTo, transition: myTransition)
                
            }
            
        }
        
    }
    
}

