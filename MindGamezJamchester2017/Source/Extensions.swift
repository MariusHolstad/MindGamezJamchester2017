//
//  Extensions.swift
//  MindGamezJamchester2017
//
//  Created by Marius Holstad on 24/06/2017.
//  Copyright © 2017 Mind Gamez. All rights reserved.
//

import SceneKit

//class SoundNode : SCNNode {
//    var volume : Float = 0 {
//        didSet {
//            runAction(SCNAction.changeVolumeTo(volume, duration: 0))
//        }
//    }
//}

extension SCNAction {
    // All the change... actions for SKAudioNode are broken. They do not work with looped audio. These are replacements
    
    public class func changeVolumeTo(_ endVolume: Float, forAudioPlayer audioPlayer: SCNAudioPlayer, duration: TimeInterval) -> SCNAction {
        var startVolume : Float!
        var distance : Float!
        
        let action = SCNAction.customAction(duration: duration) {
            node, elapsedTime in
            
            for player in node.audioPlayers {
                if player == audioPlayer {
                    
                    if let audioSource = audioPlayer.audioSource {
                        if startVolume == nil {
                            startVolume = audioSource.volume
                            distance = endVolume - startVolume
                        }
                        
                        let fraction = Float(elapsedTime / CGFloat(duration))
                        let newVolume = startVolume + (distance * fraction)
                        
                        node.removeAudioPlayer(audioPlayer)
                        audioSource.volume = newVolume
                        node.addAudioPlayer(SCNAudioPlayer(source: audioSource))
                    }
                }
            }
        }
        
        return action
    }
}

//extension SCNAction {
//    // All the change... actions for SKAudioNode are broken. They do not work with looped audio. These are replacements
//
//    public class func changeVolumeTo(_ endVolume: Float, duration: TimeInterval) -> SCNAction {
//        var startVolume : Float!
//        var distance : Float!
//
//        let action = SCNAction.customAction(duration: duration) {
//            node, elapsedTime in
//
//            if let soundNode = node as? SoundNode
//            {
//                if startVolume == nil
//                {
//                    startVolume = soundNode.volume
//                    distance = endVolume - startVolume
//                }
//
//                let fraction = Float(elapsedTime / CGFloat(duration))
//                let newVolume = startVolume + (distance * fraction)
//
//                soundNode.volume = newVolume
//            }
//        }
//
//        return action
//    }
//}

