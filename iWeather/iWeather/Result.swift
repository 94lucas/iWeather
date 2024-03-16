//
//  Result.swift
//  iWeather
//
//  Created by Lucas on 12/03/24.
//

import Foundation


struct Result: Decodable {
    
    var main: Main
    var wind: Wind
    var weather: [Weather]

    
    struct Wind: Decodable {
        let speed: Double
        
        
    }
    
    struct Weather: Decodable {
        let descricao: String
        
        enum CodingKeys: String, CodingKey {
            case descricao = "description"
            
        }
    }
    
    
    struct Main: Decodable{
        let temp: Double
    
    }
    
    
    
    
}
