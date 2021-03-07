//
//  Wall.swift
//  MacPong
//
//  Created by Simon O'Doherty on 07/03/2021.
//

import Foundation
import SpriteKit

class Wall {
    
    var wallSprite: SKSpriteNode?
    let wallName: String?
    
    var bitMask: UInt32?
    var bitTestMask: UInt32?
    
    init(_ wallName: String, _ scene: SKScene, _ bMask: UInt32, _ btMask: UInt32) {
        self.wallName = wallName
        bitMask = bMask
        bitTestMask = btMask
        
        setupSprite(scene)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSprite(_ scene: SKScene) {
        if let wName = wallName {
            if let sprite = scene.childNode(withName: "//\(wName)") as? SKSpriteNode {
                wallSprite = sprite
                wallSprite?.physicsBody = SKPhysicsBody(rectangleOf: wallSprite!.size)
                wallSprite?.physicsBody?.collisionBitMask = bitMask!
                wallSprite?.physicsBody?.contactTestBitMask = bitTestMask!
                wallSprite?.physicsBody!.allowsRotation = false
                wallSprite?.physicsBody!.pinned = true
            }
        }
    }
    
}
