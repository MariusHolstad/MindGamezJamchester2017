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
    
    var audioSources = [SCNAudioSource]()
    var interuptableSources = [SCNAudioSource: Bool]()
    var audioPlayers: [SCNAudioPlayer] {
        return baseEntity.node.audioPlayers
    }
    
    init(_ baseEntity: BaseEntity) {
        self.baseEntity = baseEntity
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didAddToEntity() {
        for audioSource in audioSources {
            baseEntity.node.addAudioPlayer(SCNAudioPlayer(source: audioSource))
        }
    }
    
    override func willRemoveFromEntity() {
        baseEntity.node.removeAllAudioPlayers()
    }
    
    func startPlaying(audioSource: SCNAudioSource, interuptable: Bool = false) {
        if let _ = entity {
            audioSources.append(audioSource)
            baseEntity.node.addAudioPlayer(SCNAudioPlayer(source: audioSource))
        } else {
            audioSources.append(audioSource)
        }
        
        if interuptable {
            interuptableSources[audioSource] = true
            baseEntity.addComponent(TapHandlerComponent(baseEntity))
        }
    }
    
    func stopPlaying(withDuration duration: Double) {
        
        for audioSource in audioSources where interuptableSources[audioSource] == true {
            for audioPlayer in audioPlayers {
                if audioPlayer.audioSource == audioSource {
                    
                    // start volume fade
                    SCNTransaction.begin()
                    SCNTransaction.animationDuration = duration
                    
                    // on completion - remove audio player
                    SCNTransaction.completionBlock = {
                        self.baseEntity.node.removeAudioPlayer(audioPlayer)
                    }
                    
                    audioPlayer.audioSource!.volume = 0
                    
                    SCNTransaction.commit()
                }
            }
        }
        
        baseEntity.removeComponent(ofType: TapHandlerComponent.self)
        
        
        
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
    }
}
