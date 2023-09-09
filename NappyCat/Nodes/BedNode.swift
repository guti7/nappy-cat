//
//  BedNode.swift
//  NappyCat
//
//  Created by peche on 9/4/23.
//

import SpriteKit

class BedNode: SKSpriteNode, EventListenerNode {
    func didMoveToScene() {
        print("bed added to scene")
        
        // give the bed a body for the purpose of detecting contacts
        let bedBodySize = CGSize(width: 40.0, height: 30.0)
        physicsBody = SKPhysicsBody(rectangleOf: bedBodySize)
        // make the body static because you don't want it to move
        physicsBody!.isDynamic = false
        // Set category and collision bitmask
        physicsBody!.categoryBitMask = PhysicsCategory.Bed
        physicsBody!.collisionBitMask = PhysicsCategory.None
    }
}
