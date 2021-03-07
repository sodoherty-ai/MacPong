//
//  Player.swift
//  MacPong
//
//  Created by Simon O'Doherty on 07/03/2021.
//

import Foundation
import SpriteKit

class Player {
    
    var batSprite: SKSpriteNode?
    var batName: String?

    var scoreSprite: SKLabelNode?
    
    var moveSteps: CGFloat = 20
    var duration: Double = 0.02
    
    var moveUp = false
    var moveDown = false
    
    var keyMoveUp: UInt16?
    var keyMoveDown: UInt16?
    
    var bitMask: UInt32?
    var bitTestMask: UInt32?
    
    var scored: UInt32?
    
    init(_ bName: String, _ scene: SKScene, _ keyUp: UInt16, _ keyDown: UInt16, _ bMask: UInt32, _ btMask: UInt32, _ score: UInt32) {

        batName = bName
        keyMoveUp = keyUp
        keyMoveDown = keyDown
        
        bitMask = bMask
        bitTestMask = btMask
        
        scored = score
        
        setupSprites(scene)
        resetScore()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func keyUp(with event: NSEvent) {
        switch event.keyCode {
        case keyMoveUp:
            moveUp = false
            if let p = batSprite {
                p.removeAllActions()
            }
        case keyMoveDown:
            moveDown = false
            if let p = batSprite {
                p.removeAllActions()
            }
        default:
            break
        }
    }
    
    func keyDown(with event: NSEvent) {
        switch event.keyCode {
        case keyMoveUp:
            moveUp = true
        case keyMoveDown:
            moveDown = true
        default:
            break
        }
    }
    
    func resetScore() {
        if let sprite = scoreSprite {
            sprite.text = "00"
        }
    }
    
    func incrementScore() {
        if let sprite = scoreSprite {
            var score = Int(sprite.text!)!
            score = score + 1
            sprite.text = String(format: "%02d", score)
        }
    }
    
    func update(_ currentTime: TimeInterval) {
        if moveUp {
            if let p = batSprite {
                p.run(SKAction.moveBy(x: 0, y: moveSteps, duration: duration))
            }
        }
        if moveDown {
            if let p = batSprite {
                p.run(SKAction.moveBy(x: 0, y: moveSteps * -1, duration: duration))
            }
        }
    }
    
    func setupSprites(_ scene: SKScene) {
        if let bName = batName {
            scoreSprite = scene.childNode(withName: "//\(bName)Score") as? SKLabelNode
            if let sprite = scene.childNode(withName: "//\(bName)") as? SKSpriteNode {
                batSprite = sprite
                batSprite?.physicsBody = SKPhysicsBody(rectangleOf: batSprite!.size)
                batSprite?.physicsBody?.collisionBitMask = bitMask!
                batSprite?.physicsBody?.contactTestBitMask = bitTestMask!
                batSprite?.physicsBody!.allowsRotation = false
            }
        }
    }
    
    func didMove(scene: SKScene) {
        setupSprites(scene)
    }
}
