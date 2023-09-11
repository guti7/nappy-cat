//
//  HookBaseNode.swift
//  NappyCat
//
//  Created by peche on 9/10/23.
//

import SpriteKit

class HookBaseNode: SKSpriteNode, EventListenerNode {
    private var hookNode  = SKSpriteNode(imageNamed: "hook")
    private var ropeNode  = SKSpriteNode(imageNamed: "rope")
    private var hookJoint : SKPhysicsJointFixed!
    
    var isHooked: Bool {
        return hookJoint != nil
    }
    
    func didMoveToScene() {
        // make sure the node has been added to the scene
        guard let scene = scene else {
            return
        }
        
        // Fix join the scene with the base node
        let ceilingFix = SKPhysicsJointFixed.joint(
            withBodyA: scene.physicsBody!,
            bodyB: self.physicsBody!,
            anchor: CGPoint.zero)
        scene.physicsWorld.add(ceilingFix)
    }
}
