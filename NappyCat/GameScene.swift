//
//  GameScene.swift
//  NappyCat
//
//  Created by peche on 8/31/23.
//

import SpriteKit

class GameScene: SKScene {
        
    override func didMove(to view: SKView) {
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
        
    }
}
