//
//  TapHandlerComponent.swift
//  MindGamezJamchester2017
//
//  Created by Marius Holstad on 24/06/2017.
//  Copyright © 2017 Mind Gamez. All rights reserved.
//

import GameplayKit

class TapHandlerComponent: GKComponent {
    
    let baseEntity: BaseEntity
    
    init(_ baseEntity: BaseEntity) {
        self.baseEntity = baseEntity
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override func didAddToEntity() {
//        <#code#>
//    }
//    
//    override func willRemoveFromEntity() {
//        <#code#>
//    }
    
    func handleTap(_ gestureRecognize: UIGestureRecognizer) {
        highlight()
        baseEntity.component(ofType: AudioPlayerComponent.self)?.stopPlaying(withDuration: GameplayConfiguration.SFX.fadeDuration)
    }
    
    private func highlight() {
            
        let node = baseEntity.node
        
        // get its material
        let material = node.geometry!.firstMaterial!
        
        // highlight it
        SCNTransaction.begin()
        SCNTransaction.animationDuration = 0.5
        
        // on completion - unhighlight
        SCNTransaction.completionBlock = {
            SCNTransaction.begin()
            SCNTransaction.animationDuration = 0.5
            
            material.emission.contents = UIColor.black
            
            SCNTransaction.commit()
        }
        
        material.emission.contents = UIColor.white
        
        SCNTransaction.commit()
    }
}
