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
    
    var audioNode = SCNNode()
    var audioSources = [SCNAudioSource]()
    var interuptableSources = [SCNAudioSource: Bool]()
    var audioPlayers: [SCNAudioPlayer] {
        return audioNode.audioPlayers
    }
    
    init(_ baseEntity: BaseEntity) {
        self.baseEntity = baseEntity
        baseEntity.node.addChildNode(audioNode)
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didAddToEntity() {
        for audioSource in audioSources {
            audioNode.addAudioPlayer(SCNAudioPlayer(source: audioSource))
        }
    }
    
    override func willRemoveFromEntity() {
        audioNode.removeAllAudioPlayers()
        audioNode.removeFromParentNode()
    }
    
    func startPlaying(audioSource: SCNAudioSource, interuptable: Bool = false) {
        if let _ = entity {
            audioSources.append(audioSource)
            audioNode.addAudioPlayer(SCNAudioPlayer(source: audioSource))
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
                    
                    // since volume fading is IMPOSSIBLE in SceneKit,
                    // we will just move the sound out of the way before removing it :)
                    var position = audioNode.position
                    position.y = position.y - 100
                    
                    // start volume fade
                    SCNTransaction.begin()
                    SCNTransaction.animationDuration = duration
                    
                    // on completion - remove audio player
                    SCNTransaction.completionBlock = {
                        self.audioNode.removeAudioPlayer(audioPlayer)
                    }
                    
                    audioNode.position = position
                    
                    SCNTransaction.commit()
                }
            }
        }
        
        baseEntity.removeComponent(ofType: TapHandlerComponent.self)
    }
}
