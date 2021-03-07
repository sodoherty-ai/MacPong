//
//  Ball.swift
//  MacPong
//
//  Created by Simon O'Doherty on 07/03/2021.
//

import Foundation
import SpriteKit

class Ball {
    
    var ballSprite: SKSpriteNode?
    
    let reset_ball_speed:CGFloat = 3
    var ballX: CGFloat = 3
    var ballY: CGFloat = 3
    
    var resetBallX: CGFloat?
    var resetBallY: CGFloat?
    
    var duration: Double = 0.02
    
    var bitMask: UInt32?
    var bitTestMask: UInt32?
    
    var bounce = 0
    let bounceSpeed = 5
    
    init(_ ballName: String, _ scene: SKScene, _ bMask: UInt32, _ btMask: UInt32) {
        bitMask = bMask
        bitTestMask = btMask
        
        if let sprite = scene.childNode(withName: "//\(ballName)") as? SKSpriteNode {
            ballSprite = sprite
            ballSprite?.physicsBody = SKPhysicsBody(rectangleOf: ballSprite!.size)
            ballSprite?.physicsBody?.collisionBitMask = bitMask!
            ballSprite?.physicsBody?.contactTestBitMask = bitTestMask!
            ballSprite?.physicsBody!.allowsRotation = false
            
            resetBallX = (ballSprite?.position.x)!
            resetBallY = (ballSprite?.position.y)!
        }
    }

    func update(_ currentTime: TimeInterval) {
        if let b = ballSprite {
            b.run(SKAction.moveBy(x: ballX, y: ballY, duration: duration))
        }
    }
    
    func bounceUpSpeed(_ bounceOnX: Bool = true) {
        if bounceOnX {
            ballX = ballX * -1
        }
        else {
            ballY = ballY * -1
        }
        
        bounce += 1
        if bounce % bounceSpeed == 0 {
            if bounceOnX {
                ballX = increment(ballX)
            }
            else {
                ballY = increment(ballY)
            }
        }
    }
    
    func increment(_ b: CGFloat) -> CGFloat {
        if b < 0 {
            return b - 1
        }
        return b + 1
    }
 
    func didBegin(_ contact: SKPhysicsContact, _ players: [Player]) {
        let contactCategory = [contact.bodyA.collisionBitMask, contact.bodyB.collisionBitMask]
                
        switch contactCategory {
        case [PhysicsCategory.wall, PhysicsCategory.ball]:
            bounceUpSpeed(false)
            
        case [PhysicsCategory.player1, PhysicsCategory.ball]:
            bounceUpSpeed()
            
        case [PhysicsCategory.player2, PhysicsCategory.ball]:
            bounceUpSpeed()
            
        case [PhysicsCategory.player1Scored, PhysicsCategory.ball]:
            players[0].incrementScore()
            ballSprite!.run(SKAction.move(to: CGPoint(x: resetBallX!, y: resetBallY!), duration: 0.0))
            ballX = reset_ball_speed * -1
            ballY = reset_ball_speed
            
        case [PhysicsCategory.player2Scored, PhysicsCategory.ball]:
            players[1].incrementScore()
            ballSprite!.run(SKAction.move(to: CGPoint(x: resetBallX!, y: resetBallY!), duration: 0.0))
            ballX = reset_ball_speed
            ballY = reset_ball_speed
            
        default:
            break
        }
    }

}
