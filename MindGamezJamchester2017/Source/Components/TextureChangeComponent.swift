//
//  TextureChangeComponent.swift
//  MindGamezJamchester2017
//
//  Created by Marius Holstad on 25/06/2017.
//  Copyright © 2017 Mind Gamez. All rights reserved.
//

import GameplayKit

class TextureChangeComponent: GKComponent {
    
    var newTexture: SCNMaterialProperty?
    
    let baseEntity: BaseEntity
    
    init(_ baseEntity: BaseEntity) {
        self.baseEntity = baseEntity
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func changeTexture() {
        
        let node = baseEntity.node
        
        // get its material
//        let material = node.geometry!.firstMaterial!
        
        // highlight it
        SCNTransaction.begin()
        SCNTransaction.animationDuration = 0.5
        
        // on completion - unhighlight
        SCNTransaction.completionBlock = {
            self.baseEntity.removeComponent(ofType: TextureChangeComponent.self)
        }
        
//        material.
        
        SCNTransaction.commit()
    }
}
