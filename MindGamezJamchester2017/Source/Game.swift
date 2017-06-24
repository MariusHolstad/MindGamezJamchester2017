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
        let alarmClockAudioPlayerComponent = AudioPlayerComponent(alarmClock)
        
        let clockAlarmSource = Assets.sound(named: "analog alarm.mp3")
        clockAlarmSource.loops = true
        clockAlarmSource.volume = GameplayConfiguration.SFX.sfxVolume * 0.1
        clockAlarmSource.isPositional = true
        clockAlarmSource.shouldStream = false
        clockAlarmSource.load()
        
        let clockTickSource = Assets.sound(named: "clock tick ambience.mp3")
        clockTickSource.loops = true
        clockTickSource.volume = GameplayConfiguration.SFX.sfxVolume
        clockTickSource.isPositional = true
        clockTickSource.shouldStream = false
        clockTickSource.load()
        
        let clockMusicSource = Assets.sound(named: "clock music layer.mp3")
        clockMusicSource.loops = true
        clockMusicSource.volume = GameplayConfiguration.SFX.musicVolume
        clockMusicSource.isPositional = true
        clockMusicSource.shouldStream = false
        clockMusicSource.load()
        
        alarmClockAudioPlayerComponent.startPlaying(audioSource: clockAlarmSource, interuptable: true)
        alarmClockAudioPlayerComponent.startPlaying(audioSource: clockTickSource)
        alarmClockAudioPlayerComponent.startPlaying(audioSource: clockMusicSource, interuptable: true)
        alarmClock.addComponent(alarmClockAudioPlayerComponent)
        // NOTE: Loop sound
        
        
        
        // Radio
        let radio = BaseEntity(inScene: scene, forNodeWithName: "Radio")
        // NOTE: Play once
        
        
        
        // Fan and Blades
        let fan = BaseEntity(inScene: scene, forNodeWithName: "Fan")
        let blades = BaseEntity(inScene: scene, forNodeWithName: "Blades")
        
        blades.node.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: 2, z: 0, duration: 1)))
//        let bladesLightNode = SCNNode()
//        var bladesLightPosition = blades.node.position
//        bladesLightPosition.y = bladesLightPosition.y + 0.2
//        bladesLightNode.light = SCNLight()
//        bladesLightNode.light!.type = .directional
//        bladesLightNode.light!.castsShadow = true
//        bladesLightNode.position = bladesLightPosition
//        bladesLightNode.localRotate(by: SCNQuaternion(-0.707, 0, 0, 0.707))
//        scene.rootNode.addChildNode(bladesLightNode)
        // NOTE: Loop sound
        
        
        
        // TV
        let tv = BaseEntity(inScene: scene, forNodeWithName: "TV")
        let tvAudioPlayerComponent = AudioPlayerComponent(tv)
        
        let tvSource = Assets.sound(named: "TV ambience.mp3")
        tvSource.loops = true
        tvSource.volume = GameplayConfiguration.SFX.sfxVolume
        tvSource.isPositional = true
        tvSource.shouldStream = false
        tvSource.load()
        
//        tvAudioPlayerComponent.startPlaying(audioSource: clockAlarmSource, interuptable: true)
        tvAudioPlayerComponent.startPlaying(audioSource: tvSource)
        tv.addComponent(tvAudioPlayerComponent)
        // NOTE: Play once
        
        
        
        // Phone
        let phone = BaseEntity(inScene: scene, forNodeWithName: "Phone_Open")
        let phoneAudioPlayerComponent = AudioPlayerComponent(phone)
        
        let phoneSource = Assets.sound(named: "phone busy ambience.mp3")
        phoneSource.loops = true
        phoneSource.volume = GameplayConfiguration.SFX.sfxVolume
        phoneSource.isPositional = true
        phoneSource.shouldStream = false
        phoneSource.load()
        
        let phoneMusicSource = Assets.sound(named: "phone music layer.mp3")
        phoneMusicSource.loops = true
        phoneMusicSource.volume = GameplayConfiguration.SFX.musicVolume
        phoneMusicSource.isPositional = true
        phoneMusicSource.shouldStream = false
        phoneMusicSource.load()
        
        phoneAudioPlayerComponent.startPlaying(audioSource: phoneSource)
        phoneAudioPlayerComponent.startPlaying(audioSource: phoneMusicSource, interuptable: true)
        phone.addComponent(phoneAudioPlayerComponent)
        // NOTE: Play once
        
        
        
        // Lamp
        let lamp = BaseEntity(inScene: scene, forNodeWithName: "Lamp")
        let lampAudioPlayerComponent = AudioPlayerComponent(lamp)
        
        let lampSource = Assets.sound(named: "lamp ambiance.mp3")
        lampSource.loops = true
        lampSource.volume = GameplayConfiguration.SFX.sfxVolume
        lampSource.isPositional = true
        lampSource.shouldStream = false
        lampSource.load()
        
        let lampMusicSource = Assets.sound(named: "lamp music layer.mp3")
        lampMusicSource.loops = true
        lampMusicSource.volume = GameplayConfiguration.SFX.musicVolume
        lampMusicSource.isPositional = true
        lampMusicSource.shouldStream = false
        lampMusicSource.load()
        
        lampAudioPlayerComponent.startPlaying(audioSource: lampSource)
        lampAudioPlayerComponent.startPlaying(audioSource: lampMusicSource, interuptable: true)
        lamp.addComponent(lampAudioPlayerComponent)
        // NOTE: Loop sound
        
        
        
        // Player
        let playerNode = SCNNode()
        let player = BaseEntity(playerNode) //BaseEntity(inScene: Assets.dae(named: "ASS_Clock.dae"), forNodeWithName: "Clock")
        player.addComponent(PlayerComponent(player))
        scene.rootNode.addChildNode(player.node)
        
        // Place the player
        player.node.position = SCNVector3(x: -5.1, y: 0, z: 3)
        
        cameraTarget = player.node
    }
    
    func setUpCamera() {
        
        // create and add a camera to the scene
        let cameraNode = SCNNode()
        cameraNode.name = "cameraNode"
        cameraNode.camera = SCNCamera()
        cameraNode.localRotate(by: SCNQuaternion(0, 0.924, 0.383, 0))
        scene.rootNode.addChildNode(cameraNode)
        
        // prevent camera from cliping through close objects
        cameraNode.camera!.zNear = 0.01
        
//        cameraNode.camera!.colorGrading.contents = MDLTexture(named: Assets.basePath + "textures/" + "ColorTableGraded.png")
        
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
        var cameraTargetPosition = cameraTarget.position
        cameraTargetPosition.y = cameraTargetPosition.y + GameplayConfiguration.camera.desiredAltitude
        cameraNode.position = cameraTargetPosition
        
        // distance constraints
        let follow = SCNDistanceConstraint(target: cameraTarget)
        follow.minimumDistance = 0
        follow.maximumDistance = 0
        
        let keepAltitude = SCNTransformConstraint.positionConstraint(inWorldSpace: true, with: {(_ node: SCNNode, _ position: SCNVector3) -> SCNVector3 in
            var position = float3(position)
            position.y = position.y + GameplayConfiguration.camera.desiredAltitude
            return SCNVector3(position)
        })
        
        let keepLeveled = SCNTransformConstraint.orientationConstraint(inWorldSpace: true, with: {(_ node: SCNNode, _ orientation: SCNQuaternion) -> SCNQuaternion in
//            let qx = orientation.x
//            let qy = orientation.y
//            let qz = orientation.z
//            let qw = orientation.w
//            
//            var heading = atan2(2*qy*qw-2*qx*qz , 1 - 2*qy^2 - 2*qz^2)
//            var attitude = asin(2*qx*qy + 2*qz*qw)
//            var bank = atan2(2*qx*qw-2*qy*qz , 1 - 2*qx^2 - 2*qz^2)
            
            return orientation
        })
        
        let accelerationConstraint = SCNAccelerationConstraint()
        accelerationConstraint.maximumLinearVelocity = 40.0
        accelerationConstraint.maximumLinearAcceleration = 30.0
        accelerationConstraint.damping = 0.2
        
        cameraNode.constraints = [follow, keepAltitude, keepLeveled, accelerationConstraint]
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

