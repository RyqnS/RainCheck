//
//  FogScene.swift
//  Clima
//
//  Created by Ryan Song on 6/15/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation
import SpriteKit


class FogScene: SKScene {
    override func didMove(to view: SKView){
        self.backgroundColor = .clear
        view.allowsTransparency = true
        makeEmitter()
    }
    
    private func makeEmitter(){
        let Emitter = SKEmitterNode(fileNamed: "Fog")!
        Emitter.position = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height)
//        Emitter.emissionAngle = (CGFloat(-180*(3.14/180)))
//        Emitter.zRotation = (CGFloat(1.6))
        Emitter.particlePositionRange.dx = UIScreen.main.bounds.width
        addChild(Emitter)
    }
}

class CloudScene: SKScene {
    override func didMove(to view: SKView){
        self.backgroundColor = .clear
        view.allowsTransparency = true
        makeEmitter()
    }
    
    private func makeEmitter(){
        let Emitter = SKEmitterNode(fileNamed: "Fog")!
        Emitter.position = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height*11/10)
//        Emitter.emissionAngle = (CGFloat(-180*(3.14/180)))
//        Emitter.zRotation = (CGFloat(1.6))
        Emitter.particleAlpha = 0.05
        Emitter.particlePositionRange.dy = CGFloat(UIScreen.main.bounds.height/10)
        Emitter.particlePositionRange.dx = UIScreen.main.bounds.width
        Emitter.particleBirthRate = 0.2
        Emitter.particleLifetime = 100
        addChild(Emitter)
    }
}
