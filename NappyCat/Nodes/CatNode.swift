//
//  CatNode.swift
//  NappyCat
//
//  Created by peche on 9/4/23.
//

import SpriteKit

class CatNode: SKSpriteNode, EventListenerNode, InteractiveNode {
    
    // Notification for interactions with the cat
    static let kCatTappedNotification = "kCatTappedNotification"
    
    func didMoveToScene() {
        // TODO: Remove debugging print statement
        print("cat added to scene")
        
        isUserInteractionEnabled = true
        
        let catBodyTexture = SKTexture(imageNamed: "cat_body_outline")
        parent!.physicsBody = SKPhysicsBody(texture: catBodyTexture, size: catBodyTexture.size())
        
        // Set bit masks
        parent!.physicsBody!.categoryBitMask = PhysicsCategory.Cat
        parent!.physicsBody!.collisionBitMask = PhysicsCategory.Block | PhysicsCategory.Edge | PhysicsCategory.Spring
        // Receive a callback when the cat makes contact
        parent!.physicsBody!.contactTestBitMask = PhysicsCategory.Bed | PhysicsCategory.Edge
    }
    
    // wake-up animation
    func wakeUp() {
        
        // Remove the cat "parts" from the body
        for child in children {
            child.removeFromParent()
        }
        
        // Reset cat to an empty node
        texture = nil
        color = SKColor.clear
        
        // load the cat wake up scene and get the cat awake sprite node
        let catAwake = SKSpriteNode(fileNamed: "CatWakeUp")!.childNode(withName: "cat_awake")!
        
        // Change the parent from the scene node to the cat node
        catAwake.move(toParent: self)
        catAwake.position = CGPoint(x: -30, y: 100)
        catAwake.isPaused = false
    }
    
    // cat curl animation
    func curlAt(scenePoint: CGPoint) {
        // remove the physics body to add manual animation
        parent!.physicsBody = nil
        
        // Remove the cat "parts from the body
        for child in children {
            child.removeFromParent()
        }
        
        // reset cat to an empty node
        texture = nil
        color = SKColor.clear
        
        // load the cat curl sks and get the cat curl sprite node
        let catCurl = SKSpriteNode(fileNamed: "CatCurl")!.childNode(withName: "cat_curl")!
        
        // Change the parent from the scene to this cat node
        catCurl.move(toParent: self)
        catCurl.position = CGPoint(x: -30, y: 100)
        catCurl.isPaused = false
        
        // Position cat in center of bed
        var localPoint = parent!.convert(scenePoint, from: scene!)
        localPoint.y += frame.size.height / 3
        
        run(SKAction.group([
            SKAction.move(to: localPoint, duration: 0.66),
            SKAction.rotate(toAngle: -parent!.zRotation, duration: 0.5)
        ]))
    }
    
    func interact() {
        print("Cat is being interacted with")
        // Send notification to notification center for each cat tap
        NotificationCenter.default.post(Notification(name: NSNotification.Name( CatNode.kCatTappedNotification), object: nil))
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        interact()
    }
}
