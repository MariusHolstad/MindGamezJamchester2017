//
//  PlayerComponent.swift
//  MindGamezJamchester2017
//
//  Created by Marius Holstad on 24/06/2017.
//  Copyright © 2017 Mind Gamez. All rights reserved.
//

import GameplayKit

class PlayerComponent: TapHandlerComponent {
    
    func moveTo(_ position: SCNVector3) {
        baseEntity.node.position = position
    }
}
