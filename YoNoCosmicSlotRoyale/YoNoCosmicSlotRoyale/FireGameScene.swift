//
//  FireGameScene.swift
//  Zygotastic Slot Winline
//
//  Created by SSS CosmicSlot Royale on 13/08/24.
//

import Foundation
import SpriteKit

class YoNoCosmicGameScene: SKScene, SKPhysicsContactDelegate {
    
    private var tank: SKSpriteNode!
    
    var health: (()->Void)?
    var addScore: ((Int)->Void)?
    var playSound: ((String)->Void)?
    
    private var fruitSpawnTimer: Timer?
    
    let bulletCategory: UInt32 = 0x1 << 0
    let fruitCategory: UInt32 = 0x1 << 1
    let groundCategory: UInt32 = 0x1 << 2
    
    override func didMove(to view: SKView) {
        setupScene()
        startFruitSpawnTimer()
        
        physicsWorld.contactDelegate = self
        
        addScore?(1)
    }
    
    private func setupScene() {
        
        backgroundColor = .clear
        tank = SKSpriteNode(imageNamed: "tank")
        tank.size = CGSize(width: 30, height: 55)
        tank.position = CGPoint(x: size.width / 2, y: tank.size.height / 2 + 5)
        tank.zPosition = 1
        addChild(tank)
        
        let ground = SKNode()
        ground.position = CGPoint(x: size.width / 2, y: 0)
        ground.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: size.width, height: 1))
        ground.physicsBody?.isDynamic = false
        ground.physicsBody?.categoryBitMask = groundCategory
        ground.physicsBody?.contactTestBitMask = fruitCategory
        ground.physicsBody?.collisionBitMask = 0
        addChild(ground)
        
    }
    
    func startFruitSpawnTimer() {
        // Schedule the fruit spawning timer
        fruitSpawnTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.spawnFruit()
        }
    }
    
    func spawnFruit() {
        
        guard let fruitName = ["F 1", "F 2", "F 3", "F 4", "F 5", "F 6", "F 7", "F 8", "F 9", "F 10", "F 11", "F 12"].randomElement() else { return }
        
        let fruit = SKSpriteNode(imageNamed: fruitName)
        fruit.size = CGSize(width: 50, height: 50)
        
        let randomX = CGFloat.random(in: 40...size.width - 40)
        fruit.position = CGPoint(x: randomX, y: size.height - 20)
        fruit.zPosition = 1
        fruit.name = "fruit"
        
        fruit.physicsBody = SKPhysicsBody(rectangleOf: fruit.size)
        fruit.physicsBody?.isDynamic = true
        fruit.physicsBody?.categoryBitMask = fruitCategory
        fruit.physicsBody?.contactTestBitMask = bulletCategory | groundCategory
        fruit.physicsBody?.collisionBitMask = 0
        fruit.physicsBody?.affectedByGravity = false
        
        addChild(fruit)
        
        let moveAction = SKAction.moveBy(x: 0, y: -size.height - fruit.size.height, duration: 5)
        let removeAction = SKAction.removeFromParent()
        
        fruit.run(SKAction.sequence([moveAction, removeAction]))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch = touches.first else { return }
        
        let touchLocation = touch.location(in: self)
        fireBullet(to: touchLocation)
    }
    
    private func fireBullet(to target: CGPoint) {
        
        playSound?("spin")
        
        let angle = atan2(target.y - tank.position.y, target.x - tank.position.x)
        
        let rotateAction = SKAction.rotate(toAngle: angle - .pi / 2, duration: 0.3, shortestUnitArc: true)
        
        tank.run(rotateAction) { [weak self] in
            
            self?.fireBullet(at: angle)
        }
    }
    
    private func fireBullet(at angle: CGFloat) {
        
        let bullet = SKSpriteNode(imageNamed: "bullet")
        
        bullet.size = CGSize(width: 30, height: 30)
        bullet.position = CGPoint(x: tank.position.x, y: tank.position.y)
        bullet.zPosition = 1
        bullet.name = "bullet"
        bullet.zRotation = angle - .pi/50
        bullet.physicsBody = SKPhysicsBody(circleOfRadius: bullet.size.width / 2)
        bullet.physicsBody?.isDynamic = true
        bullet.physicsBody?.categoryBitMask = bulletCategory
        bullet.physicsBody?.contactTestBitMask = fruitCategory
        bullet.physicsBody?.collisionBitMask = 0
        bullet.physicsBody?.affectedByGravity = false
        
        addChild(bullet)
        
        let bulletSpeed: CGFloat = 500.0
        let dx = cos(angle) * bulletSpeed
        let dy = sin(angle) * bulletSpeed
        
        bullet.physicsBody?.velocity = CGVector(dx: dx, dy: dy)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + Double.random(in: 0.5...1.7)) {
            
            bullet.removeFromParent()
            
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        if contactMask == (bulletCategory | fruitCategory) {
            if let bullet = contact.bodyA.node as? SKSpriteNode, let fruit = contact.bodyB.node as? SKSpriteNode {
                bullet.removeFromParent()
                fruit.removeFromParent()
                addBomb(p: bullet.position)
                addScore?(1)
            } else if let bullet = contact.bodyB.node as? SKSpriteNode, let fruit = contact.bodyA.node as? SKSpriteNode {
                bullet.removeFromParent()
                fruit.removeFromParent()
                addBomb(p: bullet.position)
                addScore?(1)
            }
        } else if contactMask == (fruitCategory | groundCategory) {
            if let fruit = contact.bodyA.node as? SKSpriteNode {
                fruit.removeFromParent()
                health?() // Call health closure or decrease health
            } else if let fruit = contact.bodyB.node as? SKSpriteNode {
                fruit.removeFromParent()
                health?() 
            }
        }
    }

        
    func addBomb(p: CGPoint){
            
            playSound?("win1")
            
            let bomb = SKSpriteNode(imageNamed: "bomb")
            
            bomb.name = "bullet"
            bomb.position = p
            bomb.size = CGSize(width: 40, height: 40)
            bomb.zPosition = 2
            bomb.physicsBody?.categoryBitMask = self.bulletCategory
            bomb.physicsBody?.contactTestBitMask = self.fruitCategory
            bomb.physicsBody?.collisionBitMask = 0
            bomb.physicsBody = SKPhysicsBody(circleOfRadius: bomb.size.width / 2)
            
            self.addChild(bomb)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                bomb.removeFromParent()
            }
        }
    
    
    override func update(_ currentTime: TimeInterval) {
        
        for node in children {
            if node.position.y < 0 || node.position.y > size.height {
                node.removeFromParent()
            }
        }
    }
    
    override func willMove(from view: SKView) {
        
        fruitSpawnTimer?.invalidate()
    }
    
    func endGame() {
        
        fruitSpawnTimer?.invalidate()
        
        for node in children {
            if node.name != "tank" {
                node.removeFromParent()
            }
        }
        
        self.isPaused = true
        
        let gameOverLabel = SKLabelNode(text: "GAME OVER!")
        gameOverLabel.fontSize = 50
        gameOverLabel.fontColor = .red
        gameOverLabel.position = CGPoint(x: size.width / 2, y: size.height / 1.5)
        gameOverLabel.zPosition = 10
        addChild(gameOverLabel)
        
    }

    
}
