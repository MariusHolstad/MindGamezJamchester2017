//
//  GameViewController.swift
//  MindGamezJamchester2017
//
//  Created by Marius Holstad on 23/06/2017.
//  Copyright © 2017 Mind Gamez. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit
import GameplayKit

class GameViewController: UIViewController {
    
    // MARK: Properties
    
    let game = Game()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // retrieve the SCNView
        let scnView = self.view as! SCNView
        
        // set the scene to the view
        scnView.scene = game.scene
        
        // force view to update continiously
        scnView.isPlaying = true
        
        // configure the camera control behaviour
        scnView.defaultCameraController?.automaticTarget = false
        scnView.defaultCameraController?.inertiaEnabled = true
        scnView.defaultCameraController?.dollyZoom(toTarget: 0)
        
        // show statistics such as fps and timing information
        scnView.showsStatistics = true
        
        // configure the view
        scnView.backgroundColor = UIColor.black
        
        scnView.pointOfView = game.scene.rootNode.childNode(withName: "cameraNode", recursively: false)
        
        // add a tap gesture recognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        scnView.addGestureRecognizer(tapGesture)
        
        // add a pan gesture recognizer
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        scnView.addGestureRecognizer(panGesture)
        
        // Ensure the game can manage updates for the scene.
        scnView.delegate = game
        
        // Set up entities after a point of view has been assigned.
        game.setUpEntities()
        
        game.setUpCameraConstraints()
    }
    
    @objc
    func handleTap(_ gestureRecognize: UIGestureRecognizer) {
        // retrieve the SCNView
        let scnView = self.view as! SCNView
        
        // check what nodes are tapped
        let p = gestureRecognize.location(in: scnView)
        let hitResults = scnView.hitTest(p, options: [:])
        // check that we clicked on at least one object
        if hitResults.count > 0 {
            // retrieved the first clicked object
            let result = hitResults[0]
            
            // pass the UIGestureRecognizer to the object if it has a TapHandlerComponent
            result.node.entity?.component(ofType: TapHandlerComponent.self)?.handleTap(gestureRecognize)
            
            let name = result.node.name
            if name == "Floor" || name == "Rug" {
                for player in game.players {
                    player.entity!.component(ofType: PlayerComponent.self)!.moveTo(result.worldCoordinates)
                }
            }
        }
    }
    
    @objc
    func handlePan(_ gestureRecognize: UIGestureRecognizer) {
        if let panRecognize = gestureRecognize as? UIPanGestureRecognizer {
            
            let location = panRecognize.location(in: view)
            var velocity = panRecognize.velocity(in: view)
            let viewPort = view.intrinsicContentSize
            
            let scnView = self.view as! SCNView
            if let cameraController = scnView.defaultCameraController {
                switch panRecognize.state {
                case .began:
                    cameraController.beginInteraction(location, withViewport: viewPort)
                case .ended:
                    let velocityScale: CGFloat = 0.15
                    velocity.x = velocity.x * velocityScale
                    velocity.y = velocity.y * velocityScale
                    cameraController.endInteraction(location, withViewport: viewPort, velocity: velocity)
                default:
                    let velocityScale: CGFloat = 0.003
                    velocity.x = velocity.x * velocityScale
                    velocity.y = velocity.y * velocityScale
                    cameraController.stopInertia()
                    cameraController.rotateBy(x: -Float(velocity.y), y: -Float(velocity.x))
                }
            }
        }
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

}
