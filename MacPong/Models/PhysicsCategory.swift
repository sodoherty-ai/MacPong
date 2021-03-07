//
//  PhysicsCategory.swift
//  MacPong
//
//  Created by Simon O'Doherty on 06/03/2021.
//

import Foundation
import SpriteKit

struct PhysicsCategory {
    static let notset: UInt32           = 0b000000
    static let player1: UInt32          = 0b000001
    static let player2: UInt32          = 0b000010
    static let wall: UInt32             = 0b000100
    static let ball: UInt32             = 0b001000
    static let player1Scored: UInt32    = 0b010000
    static let player2Scored: UInt32    = 0b100000
}
