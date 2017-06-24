//
//  Game.swift
//  MindGamezJamchester2017
//
//  Created by Marius Holstad on 24/06/2017.
//  Copyright © 2017 Mind Gamez. All rights reserved.
//

import GameplayKit

class Game: NSObject, SCNSceneRendererDelegate {
    
    // MARK: Properties
    
    /// Keeps track of the time for use in the update method.
    var previousUpdateTime: TimeInterval = 0
    
    /// The scene that the game controls.
    let scene = Assets.dae(named: "ASS_Room.dae")
    
    var cameraTarget: SCNNode!
    
    // An array of all nodes with a player component attached.
    var players: [SCNNode] {
        return scene.rootNode.childNodes(passingTest: { (node: SCNNode, _: UnsafeMutablePointer<ObjCBool>) -> Bool in
            if let _ = node.entity?.component(ofType: PlayerComponent.self) {
                return true
            }
            return false
        })
    }
    
    /// Holds the entities, so they won't be deallocated.
    var entities = [BaseEntity]()
    
    // MARK: Initialization
    
    override init() {
        super.init()
        
        setUpScene()
        setUpCamera()
    }
    
    func setUpScene() {
        
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
        
        // Floor
        let floor = BaseEntity(inScene: scene, forNodeWithName: "Floor")
        floor.addComponent(TapHandlerComponent(floor))
        
        // Rug
        let rug = BaseEntity(inScene: scene, forNodeWithName: "Rug")
        rug.addComponent(TapHandlerComponent(rug))
        
        // Alarm Clock
        let alarmClock = BaseEntity(inScene: scene, forNodeWithName: "Cylinder")
        
        // Radio
        let radio = BaseEntity(inScene: scene, forNodeWithName: "Radio")
        
        // Fan
        let fan = BaseEntity(inScene: scene, forNodeWithName: "Fan")
        
        // TV
        let tv = BaseEntity(inScene: scene, forNodeWithName: "TV")
        
        // Phone
        let phone = BaseEntity(inScene: scene, forNodeWithName: "Phone_Open")
        
        // Lamp
        let lamp = BaseEntity(inScene: scene, forNodeWithName: "Lamp")
        
        // Player
        let playerNode = SCNNode()
        let player = BaseEntity(playerNode) //BaseEntity(inScene: Assets.dae(named: "ASS_Clock.dae"), forNodeWithName: "Clock")
        player.addComponent(PlayerComponent(player))
        scene.rootNode.addChildNode(player.node)
        
        // Place the player
        player.node.position = SCNVector3(x: 0, y: 0, z: 0)
        
        cameraTarget = player.node
    }
    
    func setUpCamera() {
        
        // create and add a camera to the scene
        let cameraNode = SCNNode()
        cameraNode.name = "cameraNode"
        cameraNode.camera = SCNCamera()
        scene.rootNode.addChildNode(cameraNode)
        
        // place the camera
//        cameraNode.position = SCNVector3(x: 0, y: 3, z: 0)
        
//        // Activate SSAO
//        cameraNode.camera!.screenSpaceAmbientOcclusionIntensity = 1.0
//
//        // Configure SSAO
//        cameraNode.camera!.screenSpaceAmbientOcclusionRadius = 5 //scene units
//        cameraNode.camera!.screenSpaceAmbientOcclusionBias = 0.03 //scene units
//        cameraNode.camera!.screenSpaceAmbientOcclusionDepthThreshold = 0.2 //scene units
//        cameraNode.camera!.screenSpaceAmbientOcclusionNormalThreshold = 0.3
        
        
    }
    
    func setUpCameraConstraints() {
        
        let cameraNode = scene.rootNode.childNode(withName: "cameraNode", recursively: false)!
        
        // distance constraints
        let follow = SCNDistanceConstraint(target: cameraTarget)
        follow.minimumDistance = 0
        follow.maximumDistance = 0
        
        // configure a constraint to maintain a constant altitude relative to the character
        let desiredAltitude: Float = 3 //abs(cameraNode.simdWorldPosition.y)
        
        let keepAltitude = SCNTransformConstraint.positionConstraint(inWorldSpace: true, with: {(_ node: SCNNode, _ position: SCNVector3) -> SCNVector3 in
            var position = float3(position)
            position.y = position.y + desiredAltitude
            return SCNVector3( position )
        })
        
//        let accelerationConstraint = SCNAccelerationConstraint()
//        accelerationConstraint.maximumLinearVelocity = 1500.0
//        accelerationConstraint.maximumLinearAcceleration = 50.0
//        accelerationConstraint.damping = 0.05
        
        cameraNode.constraints = [follow, keepAltitude] //, accelerationConstraint]
    }
    
    // MARK: Methods
    
//    // Updates every frame.
//    func renderer(_: SCNSceneRenderer, updateAtTime time: TimeInterval) {
//        // Calculate the time change since the previous update.
//        let timeSincePreviousUpdate = time - previousUpdateTime
//
////        for player in players {
////            player.entity!.component(ofType: PlayerComponent.self)!.update(deltaTime: timeSincePreviousUpdate)
////        }
//
//        playerComponentSystem.update(deltaTime: timeSincePreviousUpdate)
//
//        // Update the previous update time to keep future calculations accurate.
//        previousUpdateTime = time
//    }
    
//    func renderer(_ renderer: SCNSceneRenderer, willRenderScene scene: SCNScene, atTime time: TimeInterval) {
//        let cameraNode = scene.rootNode.childNode(withName: "cameraNode", recursively: false)!
//        cameraNode.orientation = SCNQuaternion()
//    }
}

