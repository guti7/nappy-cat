//
//  CatNode.swift
//  NappyCat
//
//  Created by peche on 9/4/23.
//

import SpriteKit

class CatNode: SKSpriteNode, EventListenerNode {
    
    func didMoveToScene() {
        print("cat added to scene")
        
        let catBodyTexture = SKTexture(imageNamed: "cat_body_outline")
        parent!.physicsBody = SKPhysicsBody(texture: catBodyTexture, size: catBodyTexture.size())
        
        // Set bit masks
        parent!.physicsBody!.categoryBitMask = PhysicsCategory.Cat
        parent!.physicsBody!.collisionBitMask = PhysicsCategory.Block | PhysicsCategory.Edge
        // Receive a callback when the cat makes contact
        parent!.physicsBody!.contactTestBitMask = PhysicsCategory.Bed | PhysicsCategory.Edge
    }
    
    // wake-up animation
    func wakeUp() {
        
        // Remove the cat "parts" from the body
        for child in children {
            child.removeFromParent()
        }
        
        // Reset cat to an empty node
        texture = nil
        color = SKColor.clear
        
        // load the cat wake up scene and get the cat awake sprite node
        let catAwake = SKSpriteNode(fileNamed: "CatWakeUp")!.childNode(withName: "cat_awake")!
        
        // Change the parent from the scene node to the cat node
        catAwake.move(toParent: self)
        catAwake.position = CGPoint(x: -30, y: 100)
    }
}
