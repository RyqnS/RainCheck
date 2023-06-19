//
//  WeatherModel.swift
//  Clima
//
//  Created by Ryan Song on 6/13/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel {
    let conditionID: Int
    let cityName: String
    let temperature: Double
    
    var CelsiusString: String {
        return String(format: "%.1f", temperature)
    }
    
    var FahrenheitString: String {
        return String(format: "%.1f", temperature*(9/5) + 32)
    }
    
    var conditionName: [String]{
        switch conditionID {
                case 200...232:
                    return ["cloud.bolt","Thunderstorms"]
                case 300...321:
                    return ["cloud.drizzle","Light rain"]
                case 500...531:
                    return ["cloud.rain","Rainy"]
                case 600...622:
                    return ["cloud.snow","Snow"]
                case 701...781:
                    return ["cloud.fog","Fog"]
                case 800:
                    return ["sun.max","Sunny"]
                case 801...804:
                    return ["cloud.bolt","Thunderstorms"]
                default:
                    return ["cloud","Cloudy"]
                }
    }
    
}
