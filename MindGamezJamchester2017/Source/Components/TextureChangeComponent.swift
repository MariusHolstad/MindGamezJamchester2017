//
//  TextureChangeComponent.swift
//  MindGamezJamchester2017
//
//  Created by Marius Holstad on 25/06/2017.
//  Copyright © 2017 Mind Gamez. All rights reserved.
//

import GameplayKit

class TextureChangeComponent: GKComponent {
    
    var newTextureName: String?
    
    let baseEntity: BaseEntity
    
    init(_ baseEntity: BaseEntity) {
        self.baseEntity = baseEntity
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func changeTexture() {
        
        if let newTextureName = newTextureName {
            
            SCNTransaction.begin()
            SCNTransaction.animationDuration = 0.5
            
            // on completion - change material
            SCNTransaction.completionBlock = {
                
                let node = self.baseEntity.node
                node.geometry!.firstMaterial!.diffuse.contents = MDLTexture(named: newTextureName)
                
                self.baseEntity.removeComponent(ofType: TextureChangeComponent.self)
            }
            
            SCNTransaction.commit()
        }
    }
}
