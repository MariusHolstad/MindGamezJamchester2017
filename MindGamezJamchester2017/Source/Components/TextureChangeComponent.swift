//
//  TextureChangeComponent.swift
//  MindGamezJamchester2017
//
//  Created by Marius Holstad on 25/06/2017.
//  Copyright © 2017 Mind Gamez. All rights reserved.
//

import GameplayKit

class TextureChangeComponent: GKComponent {
    
    var newMaterialName: String?
    
    let baseEntity: BaseEntity
    
    init(_ baseEntity: BaseEntity) {
        self.baseEntity = baseEntity
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func changeTexture() {
        
        if let newMaterialName = newMaterialName {
            
            let node = baseEntity.node
            
            // highlight it
            SCNTransaction.begin()
            SCNTransaction.animationDuration = 0.5
            
            // on completion - change materia
            SCNTransaction.completionBlock = {
                
//                node.geometry!.materials.removeFirst()
                node.geometry!.firstMaterial! = node.geometry!.material(named: newMaterialName)!
                
//                if let newMaterial = node.geometry!.material(named: newMaterialName) {
//
//                    newMaterial.emission.contents = node.geometry!.firstMaterial!.emission.contents
//
//                    node.geometry!.firstMaterial! = newMaterial
//
//                    SCNTransaction.begin()
//                    SCNTransaction.animationDuration = 0.5
//
//                    node.geometry!.firstMaterial!.emission.contents = UIColor.black
//
//                    SCNTransaction.commit()
//                }
                
                self.baseEntity.removeComponent(ofType: TextureChangeComponent.self)
            }
            
            SCNTransaction.commit()
        }
    }
}
