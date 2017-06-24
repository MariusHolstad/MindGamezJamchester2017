//
//  AudioEntity.swift
//  MindGamezJamchester2017
//
//  Created by Marius Holstad on 24/06/2017.
//  Copyright © 2017 Mind Gamez. All rights reserved.
//

import GameplayKit

class AudioEntity: BaseEntity {
    
// init(_ node: SCNNode, soundNamed name: String) {
//        super.init(node)
//        
//        let audioSource = Assets.sound(named: name)
//        let audioPlayerComponent = AudioPlayerComponent(self, audioSource: audioSource)
//        audioPlayerComponent.audioSource.shouldStream = true
//        audioPlayerComponent.audioSource.loops = true
//        audioPlayerComponent.audioSource.volume = GameplayConfiguration.SFX.sfxVolume
//        addComponent(audioPlayerComponent)
//    }
//    
//    convenience init(inScene scene: SCNScene, forNodeWithName name: String, soundNamed soundName: String) {
//        guard let node = scene.rootNode.childNode(withName: name, recursively: false) else {
//            fatalError("Making node with name \(name) failed because the GameScene scene file contains no nodes with that name.")
//        }
//        
//        self.init(node, soundNamed: soundName)
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
}
