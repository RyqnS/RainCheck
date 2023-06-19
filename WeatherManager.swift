//
//  WeatherManager.swift
//  Clima
//
//  Created by Ryan Song on 6/12/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation

protocol WMDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}


struct WeatherManager {
    let weatherUrl = "https://api.openweathermap.org/data/2.5/weather?appid=fa73c9fd940d17ecfbe73992326634ca&units=metric"
    let geoUrl = "https://api.openweathermap.org/geo/1.0/direct?limit=5&appid=fa73c9fd940d17ecfbe73992326634ca"
    
    var delegate: WMDelegate?
    
    func getWeather(name:String){
//        let coords = getCoordfromName(name: name)
        let urlString = "\(geoUrl)&q=\(name)" //CHANGE "NAME" TO "COORDS"
        performRequest(urlString, "Geo")
    }
    
    func getWeather(latitude: Double, longitude: Double){
        let urlString = "\(weatherUrl)&lat=\(latitude)&lon=\(longitude)"
        performRequest(urlString, "Weather")
    }

    
    func performRequest(_ urlString:String, _ dataType: String){
        if let url = URL(string: urlString){
            
            let sess = URLSession(configuration:.default)
            let task = sess.dataTask(with: url) { (data,response,err) in
                if (err != nil){
                    self.delegate?.didFailWithError(error:err!)
                    return
                }
                if (dataType == "Weather"){
                    if let safeData = data {
                        if let model = self.parseJsonWeather(safeData) {
                            self.delegate?.didUpdateWeather(self, weather: model)
                        }else{
                            self.delegate?.didFailWithError(error:err!)
                        }
                    }
                } else{
                    if let safeData = data {
                        if let model = self.parseJsonGeo(safeData) {
                            getWeather(latitude: model.lat,longitude:model.lon)
                        }else{
                            self.delegate?.didFailWithError(error:err!)
                        }
                    }
                    
                }
            }
            task.resume()
        }
    }
    
    func parseJsonGeo(_ geoData:Data) -> GeoModel?{
        let decoder = JSONDecoder()
        do {
            let decodedGeoData = try decoder.decode(Array<GeoData>.self,from:geoData)
            print(decodedGeoData)
            let lat = decodedGeoData[0].lat
            let lon = decodedGeoData[0].lon
            
            let geo = GeoModel(lat: lat, lon: lon)
            return geo
            
        } catch {
            self.delegate?.didFailWithError(error:error)
            return nil
        }
        
    }
    
    func parseJsonWeather(_ weatherData:Data) -> WeatherModel?{
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self,from:weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel(conditionID: id, cityName: name, temperature: temp)
            return weather
            
        } catch {
            self.delegate?.didFailWithError(error:error)
            return nil
        }
        
    }
    
    
    
    
}
