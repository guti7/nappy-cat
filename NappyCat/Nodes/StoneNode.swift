//
//  StoneNode.swift
//  NappyCat
//
//  Created by peche on 9/16/23.
//

import SpriteKit

class StoneNode: SKSpriteNode, EventListenerNode, InteractiveNode {
    
    func didMoveToScene() {
        // TODO: Remove debugging print statement
        print("Stone node added.")
        
        isUserInteractionEnabled = true
    }
    
    func interact() {
        // TODO: Remove debugging print statement
        print("Interacted with stone node.")
    }
    
    // Respond to touches on the stone block
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        print("Stone was touched.")
        interact()
    }
}
