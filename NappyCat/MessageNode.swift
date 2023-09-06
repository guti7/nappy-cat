//
//  MessageNode.swift
//  NappyCat
//
//  Created by peche on 9/6/23.
//

import SpriteKit

class MessageNode: SKLabelNode {
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
        
    }
}
