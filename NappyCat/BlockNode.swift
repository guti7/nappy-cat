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
    }
    
    // Respond to taps on the block
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        print("destroy block")
        interact()
    }
}
