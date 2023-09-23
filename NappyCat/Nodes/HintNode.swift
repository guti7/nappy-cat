//
//  HintNode.swift
//  NappyCat
//
//  Created by peche on 9/22/23.
//

import SpriteKit

class HintNode: SKSpriteNode, EventListenerNode {
    
    func didMoveToScene() {
        color = SKColor.clear
    }
}
