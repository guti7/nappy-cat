//
//  PictureNode.swift
//  NappyCat
//
//  Created by peche on 9/18/23.
//

import SpriteKit

class PictureNode: SKSpriteNode, EventListenerNode, InteractiveNode {
    
    func didMoveToScene() {
        // enables touches on the picture node
    }
    
    func interact() {
        // add interaction with picture node
        print("Interact with picture node: \(self)")
    }
}
