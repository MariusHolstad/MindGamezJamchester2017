//
//  AudioEntity.swift
//  MindGamezJamchester2017
//
//  Created by Marius Holstad on 24/06/2017.
//  Copyright © 2017 Mind Gamez. All rights reserved.
//

import GameplayKit

class AudioEntity: BaseEntity {
    
    override init(_ node: SCNNode) {
        super.init(node)
        
        let audioSource = Assets.sound(named: "alarm.mp3")
        let audioPlayerComponent = AudioPlayerComponent(self, audioSource: audioSource)
        audioPlayerComponent.audioSource.shouldStream = true
        audioPlayerComponent.audioSource.volume = GameplayConfiguration.SFX.sfxVolume
        addComponent(audioPlayerComponent)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
