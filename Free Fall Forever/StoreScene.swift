//
//  StoreScene.swift
//  Free Fall
//
//  Created by Jason Cardinale on 11/6/18.
//  Copyright © 2018 Jason Cardinale. All rights reserved.
//

import Foundation
import SpriteKit


var color1 = defaults.bool(forKey: "color1")
var color2 = defaults.bool(forKey: "color2")
var color3 = defaults.bool(forKey: "color3")
var color4 = defaults.bool(forKey: "color4")
var color5 = defaults.bool(forKey: "color5")
var color6 = defaults.bool(forKey: "color6")
var color7 = defaults.bool(forKey: "color7")
var color8 = defaults.bool(forKey: "color8")
var color9 = defaults.bool(forKey: "color9")
var color10 = defaults.bool(forKey: "color10")
var color11 = defaults.bool(forKey: "color11")
var color12 = defaults.bool(forKey: "color12")
var color13 = defaults.bool(forKey: "color13")
var color14 = defaults.bool(forKey: "color14")
var color15 = defaults.bool(forKey: "color15")
var color16 = defaults.bool(forKey: "color16")
var color17 = defaults.bool(forKey: "color17")
var color18 = defaults.bool(forKey: "color18")
var color19 = defaults.bool(forKey: "color19")
var color20 = defaults.bool(forKey: "color20")
var color21 = defaults.bool(forKey: "color21")
var color22 = defaults.bool(forKey: "color22")
var color23 = defaults.bool(forKey: "color23")
var color24 = defaults.bool(forKey: "color24")
var color25 = defaults.bool(forKey: "color25")


let playerColors: [[CGFloat]] = [[CGFloat(1.00), CGFloat(1.00), CGFloat(1.00)],
                                 [CGFloat(1.00), CGFloat(0.00), CGFloat(0.00)],
                                 [CGFloat(0.94), CGFloat(0.44), CGFloat(0.00)],
                                 [CGFloat(0.92), CGFloat(0.90), CGFloat(0.00)],
                                 [CGFloat(0.40), CGFloat(0.85), CGFloat(0.00)],
                                 [CGFloat(0.00), CGFloat(0.74), CGFloat(0.62)],
                                 [CGFloat(0.00), CGFloat(0.25), CGFloat(0.68)],
                                 [CGFloat(0.44), CGFloat(0.00), CGFloat(0.67)],
                                 [CGFloat(0.79), CGFloat(0.00), CGFloat(0.46)],
                                 [CGFloat(0.58), CGFloat(0.00), CGFloat(0.01)],
                                 [CGFloat(0.87), CGFloat(1.00), CGFloat(0.00)],
                                 [CGFloat(0.00), CGFloat(1.00), CGFloat(0.02)],
                                 [CGFloat(0.00), CGFloat(1.00), CGFloat(0.88)],
                                 [CGFloat(0.05), CGFloat(0.00), CGFloat(1.00)],
                                 [CGFloat(1.00), CGFloat(0.00), CGFloat(0.50)],
                                 [CGFloat(1.00), CGFloat(0.46), CGFloat(0.46)],
                                 [CGFloat(0.86), CGFloat(0.84), CGFloat(0.39)],
                                 [CGFloat(0.35), CGFloat(0.76), CGFloat(0.37)],
                                 [CGFloat(0.30), CGFloat(0.59), CGFloat(0.65)],
                                 [CGFloat(0.27), CGFloat(0.36), CGFloat(0.58)],
                                 [CGFloat(0.37), CGFloat(0.23), CGFloat(0.51)],
                                 [CGFloat(0.52), CGFloat(0.24), CGFloat(0.49)],
                                 [CGFloat(0.35), CGFloat(0.17), CGFloat(0.17)],
                                 [CGFloat(0.00), CGFloat(0.17), CGFloat(0.00)],
                                 [CGFloat(0.02), CGFloat(0.02), CGFloat(0.02)]]

var ownColors = [color1, color2, color3, color4, color5, color6, color7, color8,
                 color9, color10, color11, color12, color13, color14, color15,
                 color16, color16, color17, color18, color19, color20, color21,
                 color22, color23, color24, color25]

var spendCoins = coinNumber
var currentPlayer = defaults.integer(forKey: "currentPlayer")
var colorCount = currentPlayer

class StoreScene: SKScene {
    
    let gameArea: CGRect
    var maxAspectRatio: CGFloat = 16.0 / 9.0
    override init(size: CGSize) {
        
        if UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.phone {
            if UIDevice().userInterfaceIdiom == .phone {
                switch UIScreen.main.nativeBounds.height {
                case 1136:
                    maxAspectRatio = 16.0 / 9.0
                case 1334:
                    maxAspectRatio = 16.0 / 9.0
                case 2208:
                    maxAspectRatio = 16.0 / 9.0
                case 2436:
                    maxAspectRatio = 19.5 / 9.0
                default:
                    maxAspectRatio = 19.5 / 9.0
                }
            }
        } else {
            maxAspectRatio = 4.0 / 3.0
        }
        
        let playableWidth = size.height / maxAspectRatio
        let margin = (size.width - playableWidth)*0.5
        gameArea = CGRect(x: margin, y: 0, width: playableWidth, height: size.height)
        
        super.init(size: size)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    let backToGame = SKLabelNode(fontNamed: "Comfortaa-Bold")
    let getColor = SKLabelNode(fontNamed: "Comfortaa-Bold")
    let useColor = SKLabelNode(fontNamed: "Comfortaa-Bold")
    var colorPreview = SKShapeNode(circleOfRadius: 75)
    let circle = SKShapeNode(circleOfRadius: 125)
    let coinDisplay = SKLabelNode(fontNamed: "Comfortaa-Regular")
    let coin = SKShapeNode(rectOf: CGSize(width: 50, height: 50))
    let nextColor = SKLabelNode(fontNamed: "Comfortaa-Bold")
    let previousColor = SKLabelNode(fontNamed: "Comfortaa-Bold")
    let check = SKSpriteNode(imageNamed: "check_official")
    let getReward = SKLabelNode(fontNamed: "Comfortaa-Bold")
    let coinReward = SKShapeNode(rectOf: CGSize(width: 50, height: 50))
    let coinPay = SKShapeNode(rectOf: CGSize(width: 50, height: 50))
    
    override func didMove(to view: SKView) {
        
        gameView.createAndLoadRewardBasedVideo()
        
        colorCount = currentPlayer
        
        ownColors[0] = true
        defaults.set(ownColors[0], forKey: "color1")
        
        let background = SKSpriteNode(imageNamed: "background_gradient")
        background.size = self.size
        background.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.5)
        background.zPosition = 0
        self.addChild(background)
        
        let nameTop = SKLabelNode(fontNamed: "Comfortaa-Bold")
        nameTop.text = "Customize"
        nameTop.fontSize = 125
        nameTop.fontColor = SKColor.white
        nameTop.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.8)
        nameTop.zPosition = 2
        self.addChild(nameTop)
        
        if currentPlayer != playerColors.count - 1 {
            
            nextColor.text = ">"
            nextColor.fontSize = 300
            nextColor.fontColor = SKColor.white
            nextColor.position = CGPoint(x: self.size.width*0.75, y: self.size.height*0.5)
            nextColor.zPosition = 2
            self.addChild(nextColor)
            
        }
        
        if currentPlayer != 0 {
            
            previousColor.text = "<"
            previousColor.fontSize = 300
            previousColor.fontColor = SKColor.white
            previousColor.position = CGPoint(x: self.size.width*0.25, y: self.size.height*0.5)
            previousColor.zPosition = 2
            self.addChild(previousColor)
            
        }
        
        
        check.setScale(0.75)
        check.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.25)
        check.zPosition = 2
        self.addChild(check)
        
        coinDisplay.text = "Coins: \(coinNumber)"
        coinDisplay.fontSize = 70
        coinDisplay.fontColor = SKColor.white
        coinDisplay.position = CGPoint(x: gameArea.maxX - coinDisplay.frame.size.width, y: self.size.height*0.9)
        coinDisplay.zPosition = 2
        self.addChild(coinDisplay)
            
        colorPreview.fillColor = UIColor(red:playerColors[currentPlayer][0], green:playerColors[currentPlayer][1], blue:playerColors[currentPlayer][2], alpha:1.0)
        colorPreview.strokeColor = SKColor.black
        colorPreview.glowWidth = 5
        colorPreview.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.55)
        colorPreview.zPosition = 1
        self.addChild(colorPreview)
        
        circle.path = UIBezierPath(ovalIn: CGRect(x: -128, y: -128, width: 256, height: 256)).cgPath
        circle.position = CGPoint(x: self.size.width*0.5, y: self.size.height + 256)
        circle.fillColor = UIColor(red:playerColors[currentPlayer][0], green:playerColors[currentPlayer][1], blue:playerColors[currentPlayer][2], alpha:1.0)
        circle.strokeColor = UIColor(red:playerColors[currentPlayer][0], green:playerColors[currentPlayer][1], blue:playerColors[currentPlayer][2], alpha:1.0)
        circle.glowWidth = 5
        circle.zPosition = 1;
        self.addChild(circle)
        
        
        let ballFallDown = SKAction.moveTo(y: self.size.height*0.4, duration: 0.5)
        let ballBounceUp = SKAction.moveTo(y: self.size.height*0.45, duration: 0.1)
        let ballBounceDown = SKAction.moveTo(y: self.size.height*0.4, duration: 0.1)
        let moveToScreenSequence = SKAction.sequence([ballFallDown, ballBounceUp, ballBounceDown])
        
        circle.run(moveToScreenSequence)
        
        backToGame.text = "Back"
        backToGame.fontSize = 70
        backToGame.fontColor = SKColor.white
        backToGame.position = CGPoint(x: gameArea.minX + backToGame.frame.size.width, y: self.size.height*0.9)
        backToGame.zPosition = 1
        backToGame.name = "Back"
        self.addChild(backToGame)
        
        
        if rewardLoaded {
            
            getReward.text = "Watch Video: 5"
            getReward.fontSize = 70
            getReward.fontColor = SKColor.white
            getReward.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.1)
            getReward.zPosition = 1
            getReward.name = "reward"
            self.addChild(getReward)
            
            coinReward.fillColor = SKColor.cyan
            coinReward.strokeColor = SKColor.cyan
            coinReward.glowWidth = 2
            coinReward.name = "coin"
            coinReward.position = CGPoint(x: self.size.width*0.5 + getReward.frame.size.width*0.6, y: self.size.height*0.115)
            coinReward.zRotation = 45
            coinReward.zPosition = 2
            self.addChild(coinReward)
            
        }
        
        let textFadeOut = SKAction.fadeOut(withDuration: 0)
        let textFadeIn = SKAction.fadeIn(withDuration: 2)
        
        nameTop.run(textFadeOut)
        backToGame.run(textFadeOut)
        coinDisplay.run(textFadeOut)
        colorPreview.run(textFadeOut)
        getColor.run(textFadeOut)
        getReward.run(textFadeOut)
        coinReward.run(textFadeOut)
        
        nameTop.run(textFadeIn)
        backToGame.run(textFadeIn)
        coinDisplay.run(textFadeIn)
        colorPreview.run(textFadeIn)
        getColor.run(textFadeIn)
        getReward.run(textFadeIn)
        coinReward.run(textFadeIn)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch: AnyObject in touches {
            
            let pointOfTouch = touch.location(in: self)
            
            if backToGame.contains(pointOfTouch) {
                
                let sceneToMoveTo = GameScene(size: self.size)
                sceneToMoveTo.scaleMode = self.scaleMode
                let myTransition = SKTransition.fade(withDuration: 1)
                self.view!.presentScene(sceneToMoveTo, transition: myTransition)
                
                gameView.createAndLoadRewardBasedVideo()
                
            }
            
            if nextColor.contains(pointOfTouch) && colorCount != playerColors.count - 1 {
                
                if colorCount == playerColors.count - 1 {
                    
                    nextColor.removeFromParent()
                    
                } else {
                    
                    colorCount += 1
                    
                }
                
                if colorCount == currentPlayer {
                    
                    addCheck()
                    
                } else {
                    
                    if ownColors[colorCount] {
                        
                        addUse()
                        
                    } else {
                        
                        addGet()
                        
                    }
                    
                }
                
                colorPreview.removeFromParent()
                circle.removeFromParent()
                
                colorPreview.fillColor = UIColor(red:playerColors[colorCount][0], green:playerColors[colorCount][1], blue:playerColors[colorCount][2], alpha:1.0)
                colorPreview.strokeColor = SKColor.black
                colorPreview.glowWidth = 5
                colorPreview.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.55)
                colorPreview.zPosition = 1
                self.addChild(colorPreview)
                
                let moveRight = SKAction.moveTo(x: self.size.width + 100, duration: 0)
                let moveLeft = SKAction.moveTo(x: self.size.width*0.5, duration: 0.3)
                let moveSequence = SKAction.sequence([moveRight, moveLeft])
                colorPreview.run(moveSequence)
                
                circle.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.4)
                circle.fillColor = UIColor(red:playerColors[colorCount][0], green:playerColors[colorCount][1], blue:playerColors[colorCount][2], alpha:1.0)
                circle.strokeColor = UIColor(red:playerColors[colorCount][0], green:playerColors[colorCount][1], blue:playerColors[colorCount][2], alpha:1.0)
                circle.glowWidth = 2
                circle.zPosition = 1;
                self.addChild(circle)
                
                let scaleDownCircle = SKAction.scale(to: 0, duration: 0.15)
                let scaleUpCircle = SKAction.scale(to: 1, duration: 0.3)
                let scaleCircle = SKAction.sequence([scaleDownCircle, scaleUpCircle])
                circle.run(scaleCircle)
                
            }
            
            if previousColor.contains(pointOfTouch) && colorCount != 0 {
                
                if colorCount == 0 {
                    
                    previousColor.removeFromParent()
                    
                } else {
                    
                    colorCount -= 1
                    
                }
                
                if colorCount == currentPlayer {
                    
                    addCheck()
                    
                } else {
                    
                    if ownColors[colorCount] {
                        
                        addUse()
                        
                    } else {
                        
                        addGet()
                        
                    }
                    
                }
                
                colorPreview.removeFromParent()
                circle.removeFromParent()
                
                colorPreview.fillColor = UIColor(red:playerColors[colorCount][0], green:playerColors[colorCount][1], blue:playerColors[colorCount][2], alpha:1.0)
                colorPreview.strokeColor = SKColor.black
                colorPreview.glowWidth = 5
                colorPreview.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.55)
                colorPreview.zPosition = 1
                self.addChild(colorPreview)
                
                let moveRight = SKAction.moveTo(x: self.size.width*0.5, duration: 0.3)
                let moveLeft = SKAction.moveTo(x: -100, duration: 0)
                let moveSequence = SKAction.sequence([moveLeft, moveRight])
                colorPreview.run(moveSequence)
                
                circle.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.4)
                circle.fillColor = UIColor(red:playerColors[colorCount][0], green:playerColors[colorCount][1], blue:playerColors[colorCount][2], alpha:1.0)
                circle.strokeColor = UIColor(red:playerColors[colorCount][0], green:playerColors[colorCount][1], blue:playerColors[colorCount][2], alpha:1.0)
                circle.glowWidth = 2
                circle.zPosition = 1;
                self.addChild(circle)
                
                let scaleDownCircle = SKAction.scale(to: 0, duration: 0.15)
                let scaleUpCircle = SKAction.scale(to: 1, duration: 0.3)
                let scaleCircle = SKAction.sequence([scaleDownCircle, scaleUpCircle])
                circle.run(scaleCircle)
                
            }
            
            if colorCount == 0 {
                
                previousColor.removeFromParent()
                
            } else {
                
                previousColor.removeFromParent()
                previousColor.text = "<"
                previousColor.fontSize = 300
                previousColor.fontColor = SKColor.white
                previousColor.position = CGPoint(x: self.size.width*0.25, y: self.size.height*0.5)
                previousColor.zPosition = 2
                self.addChild(previousColor)
                
            }
            
            if colorCount == playerColors.count - 1 {
                
                nextColor.removeFromParent()
                
            } else {
                
                nextColor.removeFromParent()
                nextColor.text = ">"
                nextColor.fontSize = 300
                nextColor.fontColor = SKColor.white
                nextColor.position = CGPoint(x: self.size.width*0.75, y: self.size.height*0.5)
                nextColor.zPosition = 2
                self.addChild(nextColor)
                
            }
            
            if useColor.contains(pointOfTouch) && ownColors[colorCount] {
                
                addCheck()
                currentPlayer = colorCount
                defaults.set(currentPlayer, forKey: "currentPlayer")
                
                
            }
            
            if getColor.contains(pointOfTouch) && !ownColors[colorCount] {
                
                if spendCoins >= 20 {
                
                    addUse()
                    spendCoins -= 20
                    coinNumber = spendCoins
                    coinDisplay.text = "Coins: \(spendCoins)"
                    defaults.set(coinNumber, forKey: "coinNumberSaved")
                    ownColors[colorCount] = true
                    defaults.set(ownColors[colorCount], forKey: "color\(colorCount + 1)")
                    
                } else {
                    
                    let scaleUpCoin = SKAction.scale(to: 1.25, duration: 0.25)
                    let scaleDownCoin = SKAction.scale(to: 1, duration: 0.25)
                    let scaleCoin = SKAction.sequence([scaleUpCoin, scaleDownCoin])
                    coinDisplay.run(scaleCoin)
                    
                }
                
            }
            
            if getReward.contains(pointOfTouch) {
                
                gameView.presentRewardBasedAd()
                
            }
            
        }
        
    }
    
    func addCheck() {
        
        useColor.removeFromParent()
        getColor.removeFromParent()
        check.removeFromParent()
        coinPay.removeFromParent()
        
        check.setScale(0.75)
        check.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.25)
        check.zPosition = 2
        self.addChild(check)
        
        let scaleDownDisplay = SKAction.scale(to: 0, duration: 0)
        let scaleUpDisplay = SKAction.scale(to: 0.75, duration: 0.25)
        let scaleDisplay = SKAction.sequence([scaleDownDisplay, scaleUpDisplay])
        check.run(scaleDisplay)
        
    }
    
    func addUse() {
        
        check.removeFromParent()
        useColor.removeFromParent()
        getColor.removeFromParent()
        coinPay.removeFromParent()
        
        useColor.text = "Use"
        useColor.fontSize = 75
        useColor.fontColor = SKColor.white
        useColor.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.25)
        useColor.zPosition = 1
        self.addChild(useColor)
        
        let scaleDownDisplay = SKAction.scale(to: 0, duration: 0)
        let scaleUpDisplay = SKAction.scale(to: 1, duration: 0.25)
        let scaleDisplay = SKAction.sequence([scaleDownDisplay, scaleUpDisplay])
        useColor.run(scaleDisplay)
        
    }
    
    func addGet() {
        
        check.removeFromParent()
        useColor.removeFromParent()
        getColor.removeFromParent()
        coinPay.removeFromParent()
        
        getColor.text = "Buy: 20"
        getColor.fontSize = 75
        getColor.fontColor = UIColor(red: 0.95, green: 0.77, blue: 0.06, alpha: 1.0)
        getColor.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.25)
        getColor.zPosition = 1
        self.addChild(getColor)
        
        coinPay.fillColor = SKColor.cyan
        coinPay.strokeColor = SKColor.cyan
        coinPay.glowWidth = 2
        coinPay.name = "coin"
        coinPay.position = CGPoint(x: self.size.width*0.5 + getColor.frame.size.width*0.7, y: self.size.height*0.27)
        coinPay.zRotation = 45
        coinPay.zPosition = 2
        self.addChild(coinPay)
        
        let scaleDownDisplay = SKAction.scale(to: 0, duration: 0)
        let scaleUpDisplay = SKAction.scale(to: 1, duration: 0.25)
        let scaleDisplay = SKAction.sequence([scaleDownDisplay, scaleUpDisplay])
        getColor.run(scaleDisplay)
        coinPay.run(scaleDisplay)
        
    }
    
}


