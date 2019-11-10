//
//  GameOverScene.swift
//  Free Fall
//
//  Created by Jason Cardinale on 11/4/18.
//  Copyright © 2018 Jason Cardinale. All rights reserved.
//

import Foundation
import SpriteKit

let defaults = UserDefaults()
var highScoreNumber = defaults.integer(forKey: "highScoreSaved")
var coinNumber = defaults.integer(forKey: "coinNumberSaved")

var gamesPlayed = 0

class GameOverScene: SKScene {
    
    let restartLabel = SKLabelNode(fontNamed: "Comfortaa-Bold")
    
    override func didMove(to view: SKView) {
        
        let background = SKSpriteNode(imageNamed: "background_gradient")
        background.size = self.size
        background.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.5)
        background.zPosition = 0
        self.addChild(background)
        
        let gameOverLabel = SKLabelNode(fontNamed: "Comfortaa-Bold")
        gameOverLabel.text = "Game Over"
        gameOverLabel.fontSize = 150
        gameOverLabel.fontColor = SKColor.white
        gameOverLabel.position = CGPoint(x: self.size.width/2, y: self.size.height*0.7)
        gameOverLabel.zPosition = 1
        self.addChild(gameOverLabel)
        
        let scoreLabel = SKLabelNode(fontNamed: "Comfortaa-Bold")
        scoreLabel.text = "Score: \(gameScore)"
        scoreLabel.fontSize = 100
        scoreLabel.fontColor = SKColor.white
        scoreLabel.position = CGPoint(x: self.size.width/2, y: self.size.height*0.55)
        scoreLabel.zPosition = 1
        self.addChild(scoreLabel)
        
        if gameScore > highScoreNumber {
            highScoreNumber = gameScore
            defaults.set(highScoreNumber, forKey: "highScoreSaved")
        }
        
        coinNumber = coinNum
        defaults.set(coinNumber, forKey: "coinNumberSaved")
        
        let highScoreLabel = SKLabelNode(fontNamed: "Comfortaa-Bold")
        highScoreLabel.text = "High Score: \(highScoreNumber)"
        highScoreLabel.fontSize = 100
        highScoreLabel.fontColor = SKColor.white
        highScoreLabel.position = CGPoint(x: self.size.width/2, y: self.size.height*0.45)
        highScoreLabel.zPosition = 1
        self.addChild(highScoreLabel)
        
        restartLabel.text = "Play Again"
        restartLabel.fontSize = 90
        restartLabel.fontColor = SKColor.white
        restartLabel.position = CGPoint(x: self.size.width/2, y: self.size.height*0.3)
        restartLabel.zPosition = 1
        self.addChild(restartLabel)
        
    }
    
    var lastUpdateTime: TimeInterval = 0
    var deltaFrameTime: TimeInterval = 0
    var  amountToMovePerSecond: CGFloat = 600.0
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch: AnyObject in touches {
            
            let pointOfTouch = touch.location(in: self)
            
            if restartLabel.contains(pointOfTouch) {
                
                if gamesPlayed == 1 {
                    
                    gameView.presentInterstitialAd()
                    gamesPlayed = 0
                    
                } else {
                    
                    gamesPlayed += 1
                    
                }
                
                let sceneToMoveTo = GameScene(size: self.size)
                sceneToMoveTo.scaleMode = self.scaleMode
                let myTransition = SKTransition.fade(withDuration: 0.5)
                self.view!.presentScene(sceneToMoveTo, transition: myTransition)
                levelNumber = 0
            }
            
        }
        
    }
    
}
