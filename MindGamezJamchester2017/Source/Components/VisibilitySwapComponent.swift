//
//  VisibilitySwapComponent.swift
//  MindGamezJamchester2017
//
//  Created by Marius Holstad on 25/06/2017.
//  Copyright © 2017 Mind Gamez. All rights reserved.
//

import GameplayKit

class VisibilitySwapComponent: GKComponent {
    
    var node1: SCNNode?
    var node2: SCNNode?
    
    let baseEntity: BaseEntity
    
    init(_ baseEntity: BaseEntity) {
        self.baseEntity = baseEntity
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func swapVisibility() {
        node1?.isHidden = !node1!.isHidden
        node2?.isHidden = !node2!.isHidden
    }
}
