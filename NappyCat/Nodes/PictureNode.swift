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
        isUserInteractionEnabled = true
        
        // loads images into sprite nodes
        let pictureNode = SKSpriteNode(imageNamed: "picture")
        let maskNode = SKSpriteNode(imageNamed: "picture-frame-mask")
        
        // add the crop node
        let cropNode = SKCropNode()
        cropNode.addChild(pictureNode)
        cropNode.maskNode = maskNode
        addChild(cropNode)
    }
    
    func interact() {
        // add interaction with picture node
        print("Interact with picture node: \(self)")
    }
}
