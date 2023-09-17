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
        
        // Observe for notifications of cat tap type
        NotificationCenter.default.addObserver(self, selector: #selector(catTapped), name: Notification.Name(CatNode.kCatTappedNotification), object: nil)
        
        // Fix join the scene with the base node
        let ceilingFix = SKPhysicsJointFixed.joint(
            withBodyA: scene.physicsBody!,
            bodyB: self.physicsBody!,
            anchor: CGPoint.zero)
        scene.physicsWorld.add(ceilingFix)
        
        // Construct the rope
        ropeNode.anchorPoint = CGPoint(x: 0, y: 0.5)
        ropeNode.zRotation = CGFloat(270).degreesToRadians()
        ropeNode.position = self.position
        
        // Add constraints to rope
        let range = SKRange(lowerLimit: 0.0, upperLimit: 0.0)
        let orientConstraint = SKConstraint.orient(to: hookNode, offset: range)
        ropeNode.constraints = [orientConstraint]
        scene.addChild(ropeNode)
        
        // Set up the hook
        hookNode.position = CGPoint(x: position.x,
                                    y: position.y - ropeNode.size.width)
        
        hookNode.physicsBody =
            SKPhysicsBody(circleOfRadius: hookNode.size.width / 2)
        
        hookNode.physicsBody!.categoryBitMask    = PhysicsCategory.Hook
        hookNode.physicsBody!.collisionBitMask   = PhysicsCategory.None
        hookNode.physicsBody!.contactTestBitMask = PhysicsCategory.Cat
        
        scene.addChild(hookNode)
        
        // Connect the hook to hook base by creating a spring joint
        let hookPosition = CGPoint(x: hookNode.position.x,
                                   y: hookNode.position.y + hookNode.size.height / 2)
        
        let ropeSpringJoint = SKPhysicsJointSpring.joint(withBodyA: self.physicsBody!, bodyB: hookNode.physicsBody!, anchorA: self.position, anchorB: hookPosition)
        
        scene.physicsWorld.add(ropeSpringJoint)
        
        // Apply an impulse to the hook
        hookNode.physicsBody!.applyImpulse(CGVector(dx: 50, dy: 0))

    }
    
    /// Hook the cat to the hook
    func hookCat(catPhysicsBody: SKPhysicsBody) {
        
        catPhysicsBody.velocity = CGVector(dx: 0, dy: 0)
        catPhysicsBody.angularVelocity = 0
        
        let pinPoint = CGPoint(x: hookNode.position.x,
                               y: hookNode.position.y + hookNode.size.height / 2)
        hookJoint = SKPhysicsJointFixed.joint(withBodyA: hookNode.physicsBody!, bodyB: catPhysicsBody, anchor: pinPoint)
        scene!.physicsWorld.add(hookJoint)
        
        hookNode.physicsBody!.contactTestBitMask = PhysicsCategory.None
    }
    
    @objc
    func catTapped() {
        if isHooked {
            releaseCat()
        }
    }
    
    /// Release the cat from the hook
    func releaseCat() {
        
        // Reset hooNode settings and destroy the hook joint
        hookNode.physicsBody!.categoryBitMask = PhysicsCategory.None
        hookNode.physicsBody!.contactTestBitMask = PhysicsCategory.None
        
        hookJoint.bodyA.node!.zRotation = 0
        hookJoint.bodyB.node!.zRotation = 0
        scene!.physicsWorld.remove(hookJoint)
        hookJoint = nil
    }
}
