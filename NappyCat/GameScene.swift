//
//  GameScene.swift
//  NappyCat
//
//  Created by peche on 8/31/23.
//

import SpriteKit

// Protocol for all nodes that will listen to this event
protocol EventListenerNode {
    func didMoveToScene()
}

// Protocol to distinguish between nodes
protocol InteractiveNode {
    func interact()
}

// Physics body collision categories
struct PhysicsCategory {
    static let None:  UInt32 = 0     // 0 - 0000
    static let Cat:   UInt32 = 0b1   // 1 - 0001
    static let Block: UInt32 = 0b10  // 2 - 0010
    static let Bed:   UInt32 = 0b100 // 4 - 0100
}

class GameScene: SKScene {
    // Properties
    var bedNode: BedNode!
    var catNode: CatNode!
    
    override func didMove(to view: SKView) {
        // Add background music
        SKTAudio.sharedInstance().playBackgroundMusic("backgroundMusic.mp3")
        
        // Get animations started
        self.isPaused = true
        self.isPaused = false
        
        // Calculate playable margin to support iPhone and iPad resolutions
        let maxAspectRatio: CGFloat = 16.0 / 9.0
        let maxAspectRatioHeight = size.width / maxAspectRatio
        let playableMargin: CGFloat = (size.height - maxAspectRatioHeight) / 2
        
        let playableRect = CGRect(x: 0.0,
                                  y: playableMargin,
                                  width: size.width,
                                  height: size.height - playableMargin * 2)
        
        physicsBody = SKPhysicsBody(edgeLoopFrom: playableRect)
        
        enumerateChildNodes(withName: "//*") { node, _ in
            if let eventListenerNode = node as? EventListenerNode {
                eventListenerNode.didMoveToScene()
            }
        }
        
        bedNode = (childNode(withName: "bed") as! BedNode)
        // Recursively search for the cat body node
        catNode = (childNode(withName: "//cat_body") as! CatNode)
        
    }
}
