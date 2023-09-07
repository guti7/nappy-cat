// Copyright (c) 2013-2017 Razeware LLC
//
//  SKTAudio.swift
//  NappyCat
//
//  Created by peche on 9/5/23.
//

import AVFoundation

/**
 * Audio player that uses AVFoundation to play looping background music and
 * short sound effects. For when using SKActions just ins't good enough.
 */
public class SKTAudio {
    public var backgroundMusicPlayer: AVAudioPlayer?
    public var soundEffectPlayer: AVAudioPlayer?
    
    public class func sharedInstance() -> SKTAudio {
        return SKTAudioInstance
    }
    
    public func playBackgroundMusic(_ filename: String) {
        let url = Bundle.main.url(forResource: filename, withExtension: nil)
        if (url == nil) {
            print("Could not find file: \(filename)")
            return
        }
        
        var error: NSError? = nil
        do {
            backgroundMusicPlayer = try AVAudioPlayer(contentsOf: url!)
        } catch let noMusicPlayerError as NSError {
            error = noMusicPlayerError
            backgroundMusicPlayer = nil
        }
        
        if let player = backgroundMusicPlayer {
            player.numberOfLoops = -1
            player.prepareToPlay()
            player.play()
        } else {
            print("Could not create audio player: \(error!)")
        }
    }
    
    public func pauseBackgroundMusic() {
        if let player = backgroundMusicPlayer {
            if player.isPlaying {
                player.pause()
            }
        }
    }
    
    public func playSoundEffect(_ filename: String) {
        let url = Bundle.main.url(forResource: filename, withExtension: nil)
        
        if (url == nil) {
            print("Could not find file: \(filename)")
            return
        }
        
        var error: NSError? = nil
        do {
            soundEffectPlayer = try AVAudioPlayer(contentsOf: url!)
        } catch let errorNoSoundEffectPlayer as NSError {
            error = errorNoSoundEffectPlayer
            soundEffectPlayer = nil
        }
        
        if let player = soundEffectPlayer {
            player.numberOfLoops = 0
            player.prepareToPlay()
            player.play()
        } else {
            print("Cound not create audio player: \(error!)")
        }
    }
}

private let SKTAudioInstance = SKTAudio()
