//
//  SnowScene.swift
//  Clima
//
//  Created by Ryan Song on 6/15/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation
import SpriteKit


class SnowScene: SKScene {
    override func didMove(to view: SKView){
        self.backgroundColor = .clear
        view.allowsTransparency = true
        makeEmitter()
    }
    
    private func makeEmitter(){
        let Emitter = SKEmitterNode(fileNamed: "SnowScene")!
        Emitter.position = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height)
//        Emitter.emissionAngle = (CGFloat(-180*(3.14/180)))
        Emitter.particlePositionRange.dx = UIScreen.main.bounds.width
        addChild(Emitter)
    }
}
