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
    static let None:  UInt32 = 0        //  0 -  0000
    static let Cat:   UInt32 = 0b1      //  1 -  0001
    static let Block: UInt32 = 0b10     //  2 -  0010
    static let Bed:   UInt32 = 0b100    //  4 -  0100
    static let Edge:  UInt32 = 0b1000   //  8 -  1000
    static let Label: UInt32 = 0b10000  // 16 - 10000
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    // Properties
    var bedNode: BedNode!
    var catNode: CatNode!
    var playable = true
    
    override func didMove(to view: SKView) {
        // TODO: Uncomment once testing is done
        // Add background music
//        SKTAudio.sharedInstance().playBackgroundMusic("backgroundMusic.mp3")
        
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
        physicsWorld.contactDelegate = self
        physicsBody!.categoryBitMask = PhysicsCategory.Edge
        
        enumerateChildNodes(withName: "//*") { node, _ in
            if let eventListenerNode = node as? EventListenerNode {
                eventListenerNode.didMoveToScene()
            }
        }
        
        bedNode = (childNode(withName: "bed") as! BedNode)
        // Recursively search for the cat body node
        catNode = (childNode(withName: "//cat_body") as! CatNode)
        
    }
    
    // Handle contact delegate callbacks
    func didBegin(_ contact: SKPhysicsContact) {
        // bit wise OR determines the collision
        let collision = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        // Collision is between message label and Edge
        if collision == PhysicsCategory.Label | PhysicsCategory.Edge {
            let contactNode = contact.bodyA.categoryBitMask == PhysicsCategory.Label ? contact.bodyA.node : contact.bodyB.node
            if let messageNode = contactNode as? MessageNode {
                messageNode.didBounce()
            }
        }
        
        // Game is inactive
        if !playable {
            return
        }
        
        // Collision is between Cat and Bed
        if collision == PhysicsCategory.Bed | PhysicsCategory.Cat {
            print("Cat in bed: Success")
            win()
        // Collision is between Cat and Edge
        } else if  collision == PhysicsCategory.Cat | PhysicsCategory.Edge {
            print("Cat on ground: Failure")
            lose()
        }
    }
    
    // Display in-game message
    func inGameMessage(text: String) {
        let message = MessageNode(message: text)
        message.name = "message_label"
        message.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(message)
        print("game message added")
    }
    
    // Restart current game level
    func newGame() {
        // TODO: See GameViewController for other initial game set up options
        let scene = GameScene(fileNamed: "GameScene")
        scene!.scaleMode = scaleMode
        view!.presentScene(scene)
    }
    
    // Losing scenario
    func lose() {
        playable = false
        SKTAudio.sharedInstance().pauseBackgroundMusic()
        SKTAudio.sharedInstance().playSoundEffect("lose.mp3")
        inGameMessage(text: "Try Again...")
        run(SKAction.afterDelay(5, runBlock: newGame))
        catNode.wakeUp()
    }
    
    // Winning scenario
    func win() {
        playable = false
        SKTAudio.sharedInstance().pauseBackgroundMusic()
        SKTAudio.sharedInstance().playSoundEffect("win.mp3")
        inGameMessage(text: "Nice job!")
        run(SKAction.afterDelay(3, runBlock: newGame))
        catNode.curlAt(scenePoint: bedNode.position)
    }
}
