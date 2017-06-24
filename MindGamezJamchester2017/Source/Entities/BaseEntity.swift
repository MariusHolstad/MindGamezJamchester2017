//
//  BaseEntity.swift
//  MindGamezJamchester2017
//
//  Created by Marius Holstad on 24/06/2017.
//  Copyright © 2017 Mind Gamez. All rights reserved.
//

import GameplayKit

class BaseEntity: GKEntity {
    
    let node: SCNNode
    
    init(_ node: SCNNode) {
        self.node = node
        super.init()
        node.entity = self
    }
    
    convenience init(inScene scene: SCNScene, forNodeWithName name: String) {
        guard let node = scene.rootNode.childNode(withName: name, recursively: false) else {
            fatalError("Making node with name \(name) failed because the GameScene scene file contains no nodes with that name.")
        }
        
        self.init(node)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
