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
        
        // Observe the av player for end of current video file
        NotificationCenter.default.addObserver(self, selector: #selector(didReachEndOfVideo), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
        
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
    
    /// Rewinds the playback once it reaches the end of the current video
    @objc
    func didReachEndOfVideo() {
        // TODO: Remove debugging print statement
        print("rewind")
        player.currentItem!.seek(to: CMTime.zero) { [weak self] _ in
            self?.player.play()
        }
    }
}
