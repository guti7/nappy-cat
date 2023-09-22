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
    
    /// It is disco time
    static private(set) var isDiscoTime = false
    
    /// Flag for disco time dance mood
    private var isDiscoTime: Bool = false {
        didSet {
            video.isHidden = !isDiscoTime
            DiscoBallNode.isDiscoTime = self.isDiscoTime
            
            // toggle the video play or pause with disco ball animation
            if isDiscoTime {
                video.play()
                run(spinAction)
            } else {
                video.pause()
                removeAllActions()
            }
            
            // toggle between background music and the disco music
            SKTAudio.sharedInstance().playBackgroundMusic(isDiscoTime ? "disco-sound.m4a" : "backgroundMusic.mp3")
            
            // automatically turn off disco time mode
            if isDiscoTime {
                video.run(SKAction.wait(forDuration: 5.0)) {
                    self.isDiscoTime = false
                }
            }
        }
    }
    
    /// Frame animation for the disco ball
    private let spinAction = SKAction.repeatForever(
        SKAction.animate(with: [
            SKTexture(imageNamed: "discoball1"),
            SKTexture(imageNamed: "discoball2"),
            SKTexture(imageNamed: "discoball3")
        ], timePerFrame: 0.2))

    func didMoveToScene() {
        isUserInteractionEnabled = true
        
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
        video.alpha = 0.75
        scene!.addChild(video)
        
        // video initial state
        video.isHidden = true
        video.pause()
    }
    
    func interact() {
        // TODO: Remove debugging print statement
        print("Disco time!")
        if !isDiscoTime {
            isDiscoTime = true
        }
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

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent? ) {
        super.touchesEnded(touches, with: event)
        interact()
    }
}
