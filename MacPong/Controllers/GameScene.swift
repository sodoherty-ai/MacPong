//
//  GameScene.swift
//  MacPong
//
//  Created by Simon O'Doherty on 06/03/2021.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var players = [Player]()
    var walls = [Wall]()
    var ball: Ball?
    
    override func didMove(to view: SKView) {
        players.append(Player("Player1", self, 12, 0, PhysicsCategory.player1, PhysicsCategory.ball, PhysicsCategory.player1Scored))
        players.append(Player("Player2", self, 35, 37, PhysicsCategory.player2, PhysicsCategory.ball, PhysicsCategory.player2Scored))
        
        walls.append(Wall("TopWall", self, PhysicsCategory.wall,
                          PhysicsCategory.player1 | PhysicsCategory.player2 | PhysicsCategory.ball))
        walls.append(Wall("BottomWall", self, PhysicsCategory.wall,
                          PhysicsCategory.player1 | PhysicsCategory.player2 | PhysicsCategory.ball))
        
        walls.append(Wall("Player1Scored", self, PhysicsCategory.player1Scored, PhysicsCategory.ball))
        walls.append(Wall("Player2Scored", self, PhysicsCategory.player2Scored, PhysicsCategory.ball))

        ball = Ball("Ball", self, PhysicsCategory.ball, PhysicsCategory.notset)

        physicsWorld.contactDelegate = self
        physicsWorld.gravity.dx = 0
        physicsWorld.gravity.dy = 0
    }

    func didBegin(_ contact: SKPhysicsContact) {
        ball!.didBegin(contact, players)
    }

    override func keyDown(with event: NSEvent) {
        for player in players {
            player.keyDown(with: event)
        }
    }
    
    override func keyUp(with event: NSEvent) {
        for player in players {
            player.keyUp(with: event)
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        for player in players {
            player.update(currentTime)
        }
        
        ball!.update(currentTime)

    }
    
}
