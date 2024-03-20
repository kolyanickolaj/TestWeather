//
//  Location.swift
//  TestWeather
//
//  Created by Nikolai Lipski on 20.03.24.
//

import Foundation

struct Location: Codable, Hashable {
//    var id = UUID()
    
    let name: String
    let country: String
    let lat: Double
    let lon: Double
//    let state: String
    
//        enum CodingKeys: String, CodingKey {
//            case voiceId = "voice_id"
//        }
}
