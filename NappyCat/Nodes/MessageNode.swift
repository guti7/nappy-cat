//
//  MessageNode.swift
//  NappyCat
//
//  Created by peche on 9/6/23.
//

import SpriteKit

class MessageNode: SKLabelNode {
    private var bounceCount = 0
    
    convenience init(message: String) {
        self.init(fontNamed: "AvenirNext-Regular")
        
        text      = message
        fontSize  = 200.0
        fontColor = SKColor.gray
        zPosition = 100
        
        let front       = SKLabelNode(fontNamed: "AvenirNext-Regular")
        front.text      = message
        front.fontSize  = 200.0
        front.fontColor = SKColor.white
        front.position  = CGPoint(x: -2, y: -2)
        addChild(front)
        
        // Animate the message with physics effects
        physicsBody = SKPhysicsBody(circleOfRadius: 10)
        physicsBody!.categoryBitMask = PhysicsCategory.Label
        physicsBody!.collisionBitMask = PhysicsCategory.Edge
        // Receive a callback when the cat makes contact
        physicsBody!.contactTestBitMask = PhysicsCategory.Edge
        physicsBody!.restitution = 0.7
    }
    
    // Track bounces remove once it bounces 4 times
    func didBounce() {
        // TODO: Hidden side effects - refactor?
        bounceCount += 1
        if bounceCount >= 4 {
            run(SKAction.afterDelay(1.0 / Double(bounceCount), runBlock: removeFromParent))
        }
    }
}
