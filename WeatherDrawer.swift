//
//  WeatherDrawer.swift
//  Clima
//
//  Created by Ryan Song on 6/14/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation
import UIKit

struct WeatherDrawer{
    let emitter1 = CAEmitterLayer()
    let emitter2 = CAEmitterLayer()
    
    let rain = ["Rainy","Light rain", "Thunderstorms"]
    let cloud = ["Fog","Cloudy"]
    
    
    func updateEmitter(condition: String){
        if !(cloud.contains(condition)) {
            emitter1.emitterShape = .line
            emitter1.emitterPosition = CGPoint(x: UIScreen.main.bounds.width/2, y: 0)
            emitter1.emitterSize = CGSize(width:UIScreen.main.bounds.width,height:2)
        } else{
            emitter1.emitterShape = .line
            //negative x makes the line extend downwards
            //x:0 puts the left edge of the veritcal line at the middle of the screen
            //positive y shifts the line to the right as if pushing from the side like this -->|
            emitter1.emitterPosition = CGPoint(x: -UIScreen.main.bounds.height/2, y:0)
            
            emitter1.emitterSize = CGSize(width:UIScreen.main.bounds.height,height:UIScreen.main.bounds.width)
            emitter1.setAffineTransform(CGAffineTransform(rotationAngle: -.pi / 2))
        }
        
        emitter1.emitterCells = generateEmitterCells(with: condition)
        
        
        
        
    }
    
    func generateEmitterCells(with condition: String) -> [CAEmitterCell] {
        var cells = [CAEmitterCell]()
        let cell = CAEmitterCell()
        
        
        
        if (!rain.contains(condition)){
            cell.contents = UIImage(imageLiteralResourceName: "Rain").cgImage
            cell.scale = 0.02
            cell.emissionLongitude = (180*(.pi/180))
            cell.lifetime = 5
            switch condition {
            case "Light rain":
                cell.birthRate = 50
                cell.velocity = 555
            case "Rainy":
                cell.birthRate = 70
                cell.velocity = 755
            case "Thunderstorms":
                cell.birthRate = 100
                cell.velocity = 955
            default:
                print("Error")
                break
            }
        }else{
            switch condition {
            case "Fog":
                cell.contents = UIImage(imageLiteralResourceName: "Rain").cgImage
            case "Thunderstorms":
                cell.contents = UIImage(imageLiteralResourceName: "Cloud").cgImage
                cell.scale = 0.02
                cell.emissionLongitude = (180*(.pi/180))
                cell.lifetime = 20
                cell.birthRate = 10
                cell.velocity = 15
                cell.alphaSpeed = 10
                cell.scaleRange = (0.03)
            case "Sunny":
                cell.contents = UIImage(imageLiteralResourceName: "Rain").cgImage
            case "Snow":
                cell.contents = UIImage(imageLiteralResourceName: "Rain").cgImage
            default:
                print("Error")
                break
            }
        }
        
        
        cells.append(cell)
        return cells
        
    }
}
