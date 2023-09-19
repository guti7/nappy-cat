//
//  DiscoBallNode.swift
//  NappyCat
//
//  Created by peche on 9/18/23.
//

import SpriteKit
import AVFoundation

class DiscoBallNode: SKSpriteNode, EventListenerNode, InteractiveNode {
    
    private var player: AVPlayer!
    private var video: SKVideoNode!

    func didMoveToScene() {
        
        // load video file
        let fileURL = Bundle.main.url(forResource: "discolights-loop", withExtension: "mov")!
        player = AVPlayer(url: fileURL)
        video = SKVideoNode(avPlayer: player)
        
        // position video in scene frame
        video.size = scene!.size
        video.position = CGPoint(x: scene!.frame.midX, y: scene!.frame.midY)
        video.zPosition = -1
        scene!.addChild(video)
        
        // play the video
        video.play()
    }
    
    func interact() {
        // TODO: Interact with disco ball node, play video, play music?
    }
}
