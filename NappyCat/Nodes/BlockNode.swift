//
//  BlockNode.swift
//  NappyCat
//
//  Created by peche on 9/6/23.
//

import SpriteKit

class BlockNode: SKSpriteNode, EventListenerNode, InteractiveNode {
    
    func didMoveToScene() {
        isUserInteractionEnabled = true
    }
    
    func interact() {
        isUserInteractionEnabled = false
        
        // Begin action sequence to destroy the block node
        run(SKAction.sequence([
            SKAction.playSoundFileNamed("pop.mp3", waitForCompletion: false),
            SKAction.scale(to: 0.8, duration: 0.1),
            SKAction.removeFromParent()
        ]))
    }
    
    // Respond to taps on the block
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        interact()
    }
}
