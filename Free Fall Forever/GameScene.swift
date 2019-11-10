//
//  GameScene.swift
//  Free Fall
//
//  Created by Jason Cardinale on 11/4/18.
//  Copyright © 2018 Jason Cardinale. All rights reserved.
//

import SpriteKit
import GameplayKit

let wallColors: [[CGFloat]] = [[CGFloat(1.00), CGFloat(0.76), CGFloat(0.07)],
                                 [CGFloat(0.92), CGFloat(0.13), CGFloat(0.15)],
                                 [CGFloat(0.77), CGFloat(0.90), CGFloat(0.22)],
                                 [CGFloat(0.99), CGFloat(0.65), CGFloat(0.87)],
                                 [CGFloat(0.34), CGFloat(0.35), CGFloat(0.73)],
                                 [CGFloat(0.93), CGFloat(0.30), CGFloat(0.40)],
                                 [CGFloat(0.07), CGFloat(0.80), CGFloat(0.77)],
                                 [CGFloat(0.64), CGFloat(0.80), CGFloat(0.22)],
                                 [CGFloat(0.02), CGFloat(0.32), CGFloat(0.87)],
                                 [CGFloat(0.93), CGFloat(0.35), CGFloat(0.14)],
                                 [CGFloat(0.00), CGFloat(0.58), CGFloat(0.20)],
                                 [CGFloat(0.71), CGFloat(0.20), CGFloat(0.44)],
                                 [CGFloat(0.97), CGFloat(0.62), CGFloat(0.12)],
                                 [CGFloat(0.60), CGFloat(0.50), CGFloat(0.98)]]

var gameScore = 0
var levelNumber = 0

var highScore = highScoreNumber
var coinNum = coinNumber

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    
    let scoreDisplay = SKLabelNode(fontNamed: "Comfortaa-Regular")
    let coinDisplay = SKLabelNode(fontNamed: "Comfortaa-Regular")
    
    let player = SKShapeNode()
    
    //let bulletSound = SKAction.playSoundFileNamed("1.wav", waitForCompletion: false)
    //let explosionSound = SKAction.playSoundFileNamed("2.wav", waitForCompletion: false)
    
    let startButton = SKLabelNode(fontNamed: "Comfortaa-Regular")
    let openStore = SKLabelNode(fontNamed: "Comfortaa-Regular")
    
    enum gameState {
        
        case preGame //when game state is before start of game
        case inGame //game state is during game
        case afterGame //game state is after game
        
    }
    
    var currentGameState = gameState.preGame
    
    struct PhysicsCategories {
        
        static let None : UInt32 = 0
        static let Player : UInt32 = 0b1 //1
        static let Wall : UInt32 = 0b10 //2
        static let Coin : UInt32 = 0b100 //4
        
    }
    
    func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    func random(min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }
    
    
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
    
    override func didMove(to view: SKView) {
        
        coinNum = coinNumber
        gameScore = 0
        
        self.physicsWorld.contactDelegate = self
        
        let background = SKSpriteNode(imageNamed: "background_gradient")
        background.size = self.size
        background.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.5)
        background.zPosition = 0
        self.addChild(background)
        
        player.path = UIBezierPath(ovalIn: CGRect(x: -50, y: -50, width: 100, height: 100)).cgPath
        player.fillColor = UIColor(red:playerColors[currentPlayer][0], green:playerColors[currentPlayer][1], blue:playerColors[currentPlayer][2], alpha:1.0)
        player.strokeColor = UIColor(red:playerColors[currentPlayer][0], green:playerColors[currentPlayer][1], blue:playerColors[currentPlayer][2], alpha:1.0)
        player.glowWidth = 1
        player.setScale(1)
        player.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.2)
        player.zPosition = 2
        player.physicsBody = SKPhysicsBody(circleOfRadius: 50)
        player.physicsBody!.affectedByGravity = false
        player.physicsBody!.categoryBitMask = PhysicsCategories.Player
        player.physicsBody!.collisionBitMask = PhysicsCategories.None
        player.physicsBody!.contactTestBitMask = PhysicsCategories.Wall
        self.addChild(player)
        
        scoreDisplay.text = "Score: 0"
        scoreDisplay.fontSize = 70
        scoreDisplay.fontColor = SKColor.white
        scoreDisplay.position = CGPoint(x: gameArea.minX + scoreDisplay.frame.size.width*0.6, y: self.size.height + scoreDisplay.frame.size.height)
        scoreDisplay.zPosition = 100
        self.addChild(scoreDisplay)
        
        coinDisplay.text = "Coins: \(coinNum)"
        coinDisplay.fontSize = 70
        coinDisplay.fontColor = SKColor.white
        coinDisplay.position = CGPoint(x: gameArea.maxX - coinDisplay.frame.size.width, y: self.size.height + coinDisplay.frame.size.height)
        coinDisplay.zPosition = 100
        self.addChild(coinDisplay)
        
        let moveOnToScreenAction = SKAction.moveTo(y: self.size.height*0.9, duration: 0.5)
        scoreDisplay.run(moveOnToScreenAction)
        coinDisplay.run(moveOnToScreenAction)
        
        startButton.text = "Tap to Begin"
        startButton.fontSize = 125
        startButton.fontColor = SKColor.white
        startButton.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.5)
        startButton.zPosition = 1
        startButton.alpha = 0
        self.addChild(startButton)
        
        openStore.text = "Customize"
        openStore.fontSize = 100
        openStore.fontColor = SKColor.white
        openStore.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.3)
        openStore.zPosition = 1
        openStore.alpha = 0
        self.addChild(openStore)
        
        let fadeInAction = SKAction.fadeIn(withDuration: 0.5)
        startButton.run(fadeInAction)
        openStore.run(fadeInAction)
        
    }
    
    
    func startGame() {
        
        currentGameState = gameState.inGame
        
        let fadeOutAction = SKAction.fadeIn(withDuration: 0.5)
        let deleteAction = SKAction.removeFromParent()
        let deleteSequence = SKAction.sequence([fadeOutAction, deleteAction])
        startButton.run(deleteSequence)
        openStore.run(deleteSequence)
        
        player.position = CGPoint(x: self.size.width*0.5, y: self.size.height + 200)
        let moveShipOntoScreen = SKAction.moveTo(y: self.size.height*0.75, duration: 0.5)
        let startLevelAction = SKAction.run(startNewLevel)
        let startGameSequence = SKAction.sequence([moveShipOntoScreen, startLevelAction])
        player.run(startGameSequence)
        
    }
    
    
    func addScore() {
        
        gameScore += 1
        scoreDisplay.text = "Score: \(gameScore)"
        
        if gameScore == 50 || gameScore == 100 || gameScore == 150 || gameScore == 200 || gameScore == 250 || gameScore == 300 {
            startNewLevel()
        }
        
    }
    
    
    func addCoin() {
        
        coinNum += 1
        coinNumber = coinNum
        coinDisplay.text = "Coins: \(coinNum)"
        defaults.set(coinNumber, forKey: "coinNumberSaved")
        
    }
    
    
    func runGameOver() {
        
        
        currentGameState = gameState.afterGame
        
        self.removeAllActions()
        
        self.enumerateChildNodes(withName: "Wall") {
            wall, stop in
            wall.removeAllActions()
        }
        
        let changeSceneAction = SKAction.run(changeScene)
        let waitToChangeScene = SKAction.wait(forDuration: 1)
        let fadeOutScene = SKAction.fadeOut(withDuration: 1)
        let changeSceneGroup = SKAction.group([fadeOutScene, waitToChangeScene])
        let changeSceneSequence = SKAction.sequence([changeSceneGroup, changeSceneAction])
        self.run(changeSceneSequence)
        
    }
    
    func changeScene() {
        
        let sceneToMoveTo = GameOverScene(size: self.size)
        sceneToMoveTo.scaleMode = self.scaleMode
        let myTransition = SKTransition.fade(withDuration: 0.5)
        self.view!.presentScene(sceneToMoveTo, transition: myTransition)
        
    }
    
    let coinSpawnTimes = [10.6, 12.2, 14.6, 16.2, 18.6, 20.2]
    var randCoin = 0
    var coinTime = 0.0
    var wallTime = 0.0
    var wallDuration = 3.0
    var wallRotation = CGFloat(0)
    var scaleSpeed = CGFloat(1)

    func startNewLevel() {
        
        levelNumber += 1
        wallTime = 1
        
        if self.action(forKey: "spawningWalls") != nil {
            self.removeAction(forKey: "spawningWalls")
        }
        
        switch levelNumber {
        case 1: wallDuration = 2.5
            wallRotation = CGFloat(0)
            scaleSpeed = CGFloat(1)
        case 2: wallDuration = 2.25
            wallRotation = CGFloat(0.25)
            scaleSpeed = CGFloat(1)
        case 3: wallDuration = 2.0
            wallRotation = CGFloat(0)
            scaleSpeed = CGFloat(1.15)
        case 4: wallDuration = 1.75
            wallRotation = CGFloat(0.5)
            scaleSpeed = CGFloat(1)
        case 5: wallDuration = 1.5
            wallRotation = CGFloat(0)
            scaleSpeed = CGFloat(1.2)
        case 6: wallDuration = 1.25
            wallRotation = CGFloat(0.5)
            scaleSpeed = CGFloat(1.2)
        default:
            wallDuration = 1.0
            wallRotation = CGFloat(0.75)
            scaleSpeed = CGFloat(1.25)
        }
        
        randCoin = Int.random(in: 0...coinSpawnTimes.count - 1)
        coinTime = coinSpawnTimes[randCoin]
        
        let wallSpawn = SKAction.run(spawnWall)
        let coinSpawn = SKAction.run(spawnCoin)
        let wallWait = SKAction.wait(forDuration: 0.5)
        let coinWait = SKAction.wait(forDuration: coinTime)
        let wallSpawnSequence = SKAction.sequence([wallWait, wallSpawn])
        let coinSpawnSequence = SKAction.sequence([coinWait, coinSpawn])
        let spawnWallForever = SKAction.repeatForever(wallSpawnSequence)
        let spawnCoinForever = SKAction.repeatForever(coinSpawnSequence)
        self.run(spawnWallForever, withKey: "spawningWalls")
        self.run(spawnCoinForever, withKey: "spawningCoins")
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        var body1 = SKPhysicsBody()
        var body2 = SKPhysicsBody()
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            body1 = contact.bodyA
            body2 = contact.bodyB
        } else {
            body1 = contact.bodyB
            body2 = contact.bodyA
        }
        
        if body1.categoryBitMask == PhysicsCategories.Player && body2.categoryBitMask == PhysicsCategories.Wall {
            //if the player has hit a wall
            
            body1.node?.removeFromParent()
            body2.node?.removeFromParent()
            
            runGameOver()
            
        }
        
        if body1.categoryBitMask == PhysicsCategories.Player && body2.categoryBitMask == PhysicsCategories.Coin {
            //if the player has hit a coin
            addCoin()
            
            body2.node?.removeFromParent()
            
        }
        
    }
    
    
    var wallWidth = 0.0
    var wallProb = 0.0
    var wallAngle = CGFloat(0)
    var wallSide = CGFloat(0)
    var wallCount = 0
    
    func spawnWall() {
        
        wallAngle = CGFloat(random(min: 0, max: 0))
        
        wallProb = Double(random(min: 0, max: 1))
        
        if wallProb > 0.5 {
            wallSide = CGFloat(self.size.width)
        } else {
            wallSide = CGFloat(0)
        }
        
        if wallCount < wallColors.count - 1 {
            wallCount += 1
        } else {
            wallCount = 0
        }
        
        
        
        let startPoint = CGPoint(x: wallSide, y: -self.size.height * 0.2)
        let endPoint = CGPoint(x: wallSide, y: self.size.height * 1.2)
        
        wallWidth = Double(random(min: gameArea.maxX*0.7, max: gameArea.maxX*1.5))
        
        let wall = SKShapeNode(rectOf: CGSize(width: wallWidth, height: 50))
        wall.fillColor = UIColor(red:wallColors[wallCount][0], green:wallColors[wallCount][1], blue:wallColors[wallCount][2], alpha:1.0)
        wall.strokeColor = UIColor(red:wallColors[wallCount][0], green:wallColors[wallCount][1], blue:wallColors[wallCount][2], alpha:1.0)
        wall.glowWidth = 2
        wall.name = "wall"
        wall.position = startPoint
        wall.zRotation = wallAngle
        wall.zPosition = 2
        wall.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: wallWidth, height: 50))
        wall.physicsBody!.affectedByGravity = false
        wall.physicsBody!.categoryBitMask = PhysicsCategories.Wall
        wall.physicsBody!.collisionBitMask = PhysicsCategories.None
        wall.physicsBody!.contactTestBitMask = PhysicsCategories.Player
        
        if (gameScore + 1) % 50 != 0 {
            self.addChild(wall)
            
            let moveWall = SKAction.move(to: endPoint, duration: wallDuration)
            var rotateWall = SKAction.rotate(byAngle: wallRotation, duration: wallDuration)
            if wallSide == CGFloat(0) {
                rotateWall = SKAction.rotate(byAngle: wallRotation, duration: wallDuration)
            } else {
                rotateWall = SKAction.rotate(byAngle: -wallRotation, duration: wallDuration)
            }
            let scaleWall = SKAction.scaleX(to: scaleSpeed, duration: wallDuration)
            let wallGroup = SKAction.group([moveWall, rotateWall, scaleWall])
            let deleteWall = SKAction.removeFromParent()
            let wallSequence = SKAction.sequence([wallGroup, deleteWall])
            
            if currentGameState == gameState.inGame {
                wall.run(wallSequence)
                addScore()
            }
            
        } else {
            
            addScore()
            
        }
        
    }
    
    var coinPos = CGFloat(0)
    
    func spawnCoin() {
        
        coinPos = random(min: gameArea.minX + 50, max: gameArea.maxX - 50)
        
        let startPoint = CGPoint(x: coinPos, y: -self.size.height * 0.2)
        let endPoint = CGPoint(x: coinPos, y: self.size.height * 1.2)
        
        let coin = SKShapeNode(rectOf: CGSize(width: 50, height: 50))
        coin.fillColor = SKColor.cyan
        coin.strokeColor = SKColor.cyan
        coin.glowWidth = 2
        coin.name = "coin"
        coin.position = startPoint
        coin.zRotation = 45
        coin.zPosition = 2
        coin.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 50, height: 50))
        coin.physicsBody!.affectedByGravity = false
        coin.physicsBody!.categoryBitMask = PhysicsCategories.Coin
        coin.physicsBody!.collisionBitMask = PhysicsCategories.None
        coin.physicsBody!.contactTestBitMask = PhysicsCategories.Player
        self.addChild(coin)
        
        let moveCoin = SKAction.move(to: endPoint, duration: wallDuration*1.5)
        let rotateCoin = SKAction.rotate(byAngle: 100, duration: wallDuration*2)
        let scaleUpCoin = SKAction.scale(to: 1.5, duration: 0.25)
        let scaleDownCoin = SKAction.scale(to: 1, duration: 0.25)
        let scaleCoin = SKAction.sequence([scaleUpCoin, scaleDownCoin])
        let keepScalingCoin = SKAction.repeatForever(scaleCoin)
        let deleteCoin = SKAction.removeFromParent()
        let coinGroup = SKAction.group([moveCoin, rotateCoin, keepScalingCoin])
        let coinSequence = SKAction.sequence([coinGroup, deleteCoin])
        
        if currentGameState == gameState.inGame {
            coin.run(coinSequence)
        }
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch: AnyObject in touches {
            
            let pointOfTouch = touch.location(in: self)
            
            if !openStore.contains(pointOfTouch) {
                
                if currentGameState == gameState.preGame {
                    startGame()
                }
                
            }
            
            if openStore.contains(pointOfTouch) {
                
                if currentGameState == gameState.preGame {
                    
                    let sceneToMoveTo = StoreScene(size: self.size)
                    sceneToMoveTo.scaleMode = self.scaleMode
                    let myTransition = SKTransition.fade(withDuration: 1)
                    self.view!.presentScene(sceneToMoveTo, transition: myTransition)
                    
                }
                
            }
            
        }
        
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch: AnyObject in touches {
            
            let pointOfTouch = touch.location(in: self)
            let previousPointOfTouch = touch.previousLocation(in: self)
            let amountDragged = pointOfTouch.x - previousPointOfTouch.x
            
            
            if currentGameState == gameState.inGame {
                player.position.x += amountDragged*1.25
            }
            
            if player.position.x > gameArea.maxX - 50 {
                player.position.x = gameArea.maxX - 50
            }
            
            if player.position.x < gameArea.minX + 50 {
                player.position.x = gameArea.minX + 50
            }
        }
        
    }
    
}
