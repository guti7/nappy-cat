//
//  HintNode.swift
//  NappyCat
//
//  Created by peche on 9/22/23.
//

import SpriteKit

class HintNode: SKSpriteNode, EventListenerNode {
    
    /// The path for the arrow hint shape node
    var arrowPath: CGPath = {
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 0.5, y: 65.69))
        bezierPath.addLine(to: CGPoint(x: 74.99, y: 1.5))
        bezierPath.addLine(to: CGPoint(x: 74.99, y: 38.66))
        bezierPath.addLine(to: CGPoint(x: 257.5, y: 38.66))
        bezierPath.addLine(to: CGPoint(x: 257.5, y: 92.72))
        bezierPath.addLine(to: CGPoint(x: 74.99, y: 92.72))
        bezierPath.addLine(to: CGPoint(x: 74.99, y: 126.5))
        bezierPath.addLine(to: CGPoint(x: 0.5, y: 65.69))
        bezierPath.close()
        
        return bezierPath.cgPath
    }()
    
    func didMoveToScene() {
        color = SKColor.clear
        
        // Create a shape node from arrow path
        let shape = SKShapeNode(path: arrowPath)
        shape.strokeColor = SKColor.gray
        shape.lineWidth = 4
        shape.fillColor = SKColor.white
        shape.fillTexture = SKTexture(imageNamed: "wood_tinted")
        shape.alpha = 0.8
        
        // Add a bouncing animation
        let move = SKAction.moveBy(x: -40, y: 0, duration: 1.0)
        let bounce = SKAction.sequence([
            move,
            move.reversed()
        ])
        let bounces = SKAction.repeat(bounce, count: 3)
        
        // Remove hint after bonce animation is complete
        shape.run(bounces) {
            self.removeFromParent()
        }
        
        addChild(shape)
    }
}
