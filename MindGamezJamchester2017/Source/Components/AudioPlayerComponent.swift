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
    
    private func stopPlaying(withDuration duration: Double) {
            
        // start volume fade
        SCNTransaction.begin()
        SCNTransaction.animationDuration = duration
        
        // on completion - remove audio player
        SCNTransaction.completionBlock = {
            if let baseEntity = self.entity as? BaseEntity {
                baseEntity.node.removeAudioPlayer(self.audioPlayer!)
                self.audioPlayer = nil
            }
        }
        
        audioSource.volume = 0
        
        SCNTransaction.commit()
    }
}
