//  Copyright (c) 2013-2017 Razeware LLC
//
//  SKAction+Extensions.swift
//  NappyCat
//
//  Created by peche on 9/6/23.
//

import SpriteKit

public extension SKAction {
    // Performs an action after the specified delay.
    class func afterDelay(_ delay: TimeInterval, performAction action: SKAction) -> SKAction {
        return SKAction.sequence([SKAction.wait(forDuration: delay), action])
    }
    
    // Performs a block after the specified delay
    class func afterDelay(_ delay: TimeInterval, runBlock block: @escaping () -> Void) -> SKAction {
        return SKAction.afterDelay(delay, performAction: SKAction.run(block))
    }
}
