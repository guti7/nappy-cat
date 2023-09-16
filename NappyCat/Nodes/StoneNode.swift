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
        
        // Make sure the scene is loaded
        guard let scene = scene else {
            return
        }
        
        // The node's parent is still the scene
        if parent == scene {
            scene.addChild(StoneNode.makeCompoundNode(in: scene))
        }
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
    
    /// Looks through the scene and binds together all the stone pieces
    static func makeCompoundNode(in scene: SKScene) -> SKNode {
        let compound = StoneNode()
        // TODO: Remove debugging print statement
        print("About to join any stone nodes to one compound stone node")
        
        return compound
    }
}
