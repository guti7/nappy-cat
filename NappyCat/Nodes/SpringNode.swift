//
//  SpringNode.swift
//  NappyCat
//
//  Created by peche on 9/9/23.
//

import SpriteKit

class SpringNode: SKSpriteNode, EventListenerNode, InteractiveNode {
    
    
    func didMoveToScene() {
        print("Spring added")
    }
    
    func interact() {
        print("Spring interaction recorded")
    }
}
