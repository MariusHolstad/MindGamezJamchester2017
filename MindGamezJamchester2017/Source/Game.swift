//
//  Game.swift
//  MindGamezJamchester2017
//
//  Created by Marius Holstad on 24/06/2017.
//  Copyright © 2017 Mind Gamez. All rights reserved.
//

import SceneKit

class Game: NSObject, SCNSceneRendererDelegate {
    
    // MARK: Properties
    
    /// The scene that the game controls.
    let scene = Assets.dae(named: "ASS_Room.dae") //SCNScene(named: "GameScene.scn")!
    
    /// Holds the entities, so they won't be deallocated.
    var entities = [BaseEntity]()
    
    // MARK: Initialization
    
    override init() {
        super.init()
        
        setUpScene()
    }
    
    func setUpScene() {
        
        // create and add a camera to the scene
        let cameraNode = SCNNode()
        cameraNode.name = "cameraNode"
        cameraNode.camera = SCNCamera()
        scene.rootNode.addChildNode(cameraNode)
        
//        // place the camera
//        cameraNode.position = SCNVector3(x: 0, y: 0, z: 15)
        
        // create and add a light to the scene
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light!.type = .omni
        lightNode.position = SCNVector3(x: 0, y: 10, z: 10)
        scene.rootNode.addChildNode(lightNode)
        
        // create and add an ambient light to the scene
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light!.type = .ambient
        ambientLightNode.light!.color = UIColor.darkGray
        scene.rootNode.addChildNode(ambientLightNode)
    }
    
    /// Sets up the entities for the scene.
    func setUpEntities() {
        
//        let clockEntity = TappableAudioEntity(inScene: scene, forNodeWithName: "Clock")
//        entities.append(clockEntity)
    }
}
