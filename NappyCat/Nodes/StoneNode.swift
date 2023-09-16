//
//  StoneNode.swift
//  NappyCat
//
//  Created by peche on 9/16/23.
//

import SpriteKit

class StoneNode: SKSpriteNode, EventListenerNode, InteractiveNode {
    
    func didMoveToScene() {
        // Make sure the scene is loaded
        guard let scene = scene else {
            return
        }
        
        // The node's parent is still the scene
        if parent == scene {
            scene.addChild(StoneNode.makeCompoundNode(in: scene))
        }
    }
    
    func interact() {
        // TODO: Remove debugging print statement
        print("Interacted with stone node.")
    }
    
    // Respond to touches on the stone block
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        interact()
    }
    
    /// Looks through the scene and binds together all the stone pieces
    static func makeCompoundNode(in scene: SKScene) -> SKNode {
        let compound = StoneNode()
        
        // Move the stone nodes to the compound node hierarchy
        for stone in scene.children.filter({ node in node is StoneNode }) {
            stone.removeFromParent()
            compound.addChild(stone)
        }
        
        // Add physics bodies to all stone nodes in the compound
        let bodies = compound.children.map { node in
            SKPhysicsBody(rectangleOf: node.frame.size, center: node.position)
        }
        
        // Set up physics body for the compound node
        compound.physicsBody = SKPhysicsBody(bodies: bodies)
        compound.physicsBody!.categoryBitMask = PhysicsCategory.Block
        compound.physicsBody!.collisionBitMask = PhysicsCategory.Edge | PhysicsCategory.Cat | PhysicsCategory.Block
        compound.isUserInteractionEnabled = true
        compound.zPosition = 1
        
        return compound
    }
}
