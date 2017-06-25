//
//  AssetLoader.swift
//  MindGamezJamchester2017
//
//  Created by Marius Holstad on 24/06/2017.
//  Copyright © 2017 Mind Gamez. All rights reserved.
//

import SceneKit

struct Assets {
    static let basePath = "art.scnassets/"
    
    private static let daePath = basePath + "3D/"
    private static let scenesPath = basePath + "scenes/"
    private static let soundsPath = basePath + "sounds/"
    
    static func dae(named name: String) -> SCNScene {
        guard let scene = SCNScene(named: daePath + name) else {
            fatalError("Failed to load dae asset \(name).")
        }
        return scene
    }
    
    static func scene(named name: String) -> SCNScene {
        guard let scene = SCNScene(named: scenesPath + name) else {
            fatalError("Failed to load scene \(name).")
        }
        return scene
    }
    
    static func sound(named name: String) -> SCNAudioSource {
        guard let source = SCNAudioSource(named: soundsPath + name) else {
            fatalError("Failed to load audio source \(name).")
        }
        return source
    }
}
