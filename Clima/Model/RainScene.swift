//
//  RainScene.swift
//  Clima
//
//  Created by Ryan Song on 6/14/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation
import SpriteKit

class RainScene: SKScene {
    override func didMove(to view: SKView){
        self.backgroundColor = .clear
        view.allowsTransparency = true

        makeEmitter()
    }
    
    private func makeEmitter(){
        let Emitter = SKEmitterNode(fileNamed: "RainFall")!
        Emitter.position = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height)
//        Emitter.emissionAngle = (CGFloat(-180*(3.14/180)))
        Emitter.particlePositionRange.dx = UIScreen.main.bounds.width
        addChild(Emitter)
    }
}

class LightRainScene: SKScene {
    override func didMove(to view: SKView){
        self.backgroundColor = .clear
        view.allowsTransparency = true

        makeEmitter()
    }
    
    private func makeEmitter(){
        let Emitter = SKEmitterNode(fileNamed: "RainFall")!
        Emitter.position = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height)
//        Emitter.emissionAngle = (CGFloat(-180*(3.14/180)))
        Emitter.particlePositionRange.dx = UIScreen.main.bounds.width
        Emitter.particleSpeed = 550
        Emitter.particleBirthRate = 3
        Emitter.particleLifetime = 5
        addChild(Emitter)
    }
}

class StormScene: SKScene {
    let lightningStrikeColor = UIColor(red: 255/255, green: 212/255, blue: 251/255, alpha: 1)
    let flickerInterval = TimeInterval(0.04)

    
    override func didMove(to view: SKView){
        self.backgroundColor = .clear
        view.allowsTransparency = true
        makeEmitter()
        let _ = Timer.scheduledTimer(timeInterval: 5,
                                             target: self,
                                         selector: #selector(doAction),
                                             userInfo: nil,
                                             repeats: true)
        let _ = Timer.scheduledTimer(timeInterval: 5,
                                             target: self,
                                         selector: #selector(doAction),
                                             userInfo: nil,
                                             repeats: true)
    
    }
    
    private func makeEmitter(){
        let Emitter1 = SKEmitterNode(fileNamed: "RainFall")!
        Emitter1.position = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height*11/10)
        //        Emitter.emissionAngle = (CGFloat(-180*(3.14/180)))
        Emitter1.particlePositionRange.dx = UIScreen.main.bounds.width
        Emitter1.particleSpeed = 700
        Emitter1.particleBirthRate *= 1.5
        
        
        let Emitter2 = SKEmitterNode(fileNamed: "Fog")!
        Emitter2.position = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height*11/10)
        //        Emitter.emissionAngle = (CGFloat(-180*(3.14/180)))
        //        Emitter.zRotation = (CGFloat(1.6))
        Emitter2.particleAlpha = 0.05
        Emitter2.particleScale = 0.1
        Emitter2.particleSpeed = 5
        Emitter2.particlePositionRange.dy = CGFloat(UIScreen.main.bounds.height/10)
        Emitter2.particlePositionRange.dx = UIScreen.main.bounds.width
        Emitter2.particleBirthRate = 3
        Emitter2.particleLifetime = 50
        addChild(Emitter2)
        
        addChild(Emitter1)
    }
    
    @objc func doAction () {
        let startingX = Float.random(in: 0...Float(UIScreen.main.bounds.width))
        let strikeStartingPoint = CGPoint(x: CGFloat(startingX), y: frame.size.height*11/10)
        let lightningPath = genrateLightningPath(startingFrom: strikeStartingPoint, angle: 0, isBranch: false)
        
        lightningStrike(throughPath: lightningPath, maxFlickeringTimes: 5)
    }
    
    func createLine(pointA: CGPoint, pointB: CGPoint) -> SKShapeNode {
        let pathToDraw = CGMutablePath()
        pathToDraw.move(to: pointA)
        pathToDraw.addLine(to: pointB)
        
        let line = SKShapeNode()
        line.path = pathToDraw
        line.glowWidth = 1
        line.strokeColor = lightningStrikeColor
        
        return line
    }

    func genrateLightningPath(startingFrom: CGPoint, angle: CGFloat, isBranch: Bool) -> [SKShapeNode] {
        var strikePath: [SKShapeNode] = []
        
        var startPoint = startingFrom
        var endPoint = CGPoint(x: startingFrom.x, y: startingFrom.y)

        let numberOfLines = isBranch ? 50 : 120
        
        var idx = 0
        while idx < numberOfLines {
            strikePath.append(createLine(pointA: startPoint, pointB: endPoint))
            startPoint = endPoint
            
            let r = CGFloat(10)
            endPoint.y -= r * cos(angle) + CGFloat.random(in: -10 ... 10)
            endPoint.x += r * sin(angle) + CGFloat.random(in: -10 ... 10)

            if Int.random(in: 0 ... 100) == 1 {
                let branchingStartPoint = endPoint
                let branchingAngle = CGFloat.random(in: -CGFloat.pi / 4 ... CGFloat.pi / 4)
                
                strikePath.append(contentsOf: genrateLightningPath(startingFrom: branchingStartPoint, angle: branchingAngle, isBranch: true))
            }
            idx += 1
        }
        
        return strikePath
    }
    
   

    func lightningStrike(throughPath: [SKShapeNode], maxFlickeringTimes: Int) {
        let fadeTime = TimeInterval(CGFloat.random(in: 0.005 ... 0.03))
        let waitAction = SKAction.wait(forDuration: flickerInterval)
        
        let reduceAlphaAction = SKAction.fadeAlpha(to: 0.0, duration: fadeTime)
        let increaseAlphaAction = SKAction.fadeAlpha(to: 1.0, duration: fadeTime)
        let flickerSeq = [waitAction, reduceAlphaAction, increaseAlphaAction]

        var seq: [SKAction] = []
        
        let numberOfFlashes = Int.random(in: 1 ... maxFlickeringTimes)

        for _ in 1 ... numberOfFlashes {
            seq.append(contentsOf: flickerSeq)
        }
        
        for line in throughPath {
            seq.append(SKAction.fadeAlpha(to: 0, duration: 0.25))
            seq.append(SKAction.removeFromParent())
            
            line.run(SKAction.sequence(seq))
            self.addChild(line)
        }

    }
}

