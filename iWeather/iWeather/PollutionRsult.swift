//
//  PollutionRsult.swift
//  iWeather
//
//  Created by Lucas on 15/03/24.
//

import Foundation

struct PollutionRsult: Decodable{
    
    let list: [Main]
    
    struct Main: Decodable {
        let main: Aqi
        
        struct Aqi: Decodable {
            let aqi: Int
        }
    }
    
}
