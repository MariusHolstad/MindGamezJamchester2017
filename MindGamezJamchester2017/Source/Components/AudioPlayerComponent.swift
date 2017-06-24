//
//  AudioPlayerComponent.swift
//  MindGamezJamchester2017
//
//  Created by Marius Holstad on 24/06/2017.
//  Copyright © 2017 Mind Gamez. All rights reserved.
//

import GameplayKit

class AudioPlayerComponent: GKComponent {
    
    let baseEntity: BaseEntity
    
    var audioSource: SCNAudioSource
    var audioPlayer: SCNAudioPlayer?
    
    init(_ baseEntity: BaseEntity, audioSource: SCNAudioSource) {
        self.baseEntity = baseEntity
        self.audioSource = audioSource
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didAddToEntity() {
        audioPlayer = SCNAudioPlayer(source: audioSource)
        baseEntity.node.addAudioPlayer(audioPlayer!)
    }
    
    override func willRemoveFromEntity() {
        if let audioPlayer = audioPlayer {
            baseEntity.node.removeAudioPlayer(audioPlayer)
        }
    }
    
    func stopPlaying(withDuration duration: Double) {
        
        baseEntity.node.removeAudioPlayer(self.audioPlayer!)
        self.audioPlayer = nil
        
//        // start volume fade
//        SCNTransaction.begin()
//        SCNTransaction.animationDuration = duration
//
//        // on completion - remove audio player
//        SCNTransaction.completionBlock = {
//            if let baseEntity = self.entity as? BaseEntity {
//                baseEntity.node.removeAudioPlayer(self.audioPlayer!)
//                self.audioPlayer = nil
//            }
//        }
//
//        for audioPlayer in baseEntity.node.audioPlayers {
//            audioPlayer.audioSource!.volume = 0
//        }
//
//
////        let currentVolume: Float = audioSource.volume
////        let wantedVolume: Float = 0
////        let changeVolume = SCNAction.customAction(duration: duration) { (node, elapsedTime) -> () in
////            let percentage: Float = Float(elapsedTime) / Float(duration)
//////            self.audioSource.volume = 0 //(1 - percentage) * currentVolume + percentage * wantedVolume
////
////            for audioPlayer in self.baseEntity.node.audioPlayers {
////                audioPlayer.audioSource!.volume = 0
////            }
////        }
////        baseEntity.node.runAction(changeVolume)
//
//        SCNTransaction.commit()
    }
}
