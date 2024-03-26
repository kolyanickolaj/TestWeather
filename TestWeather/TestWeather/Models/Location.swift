//
//  Location.swift
//  TestWeather
//
//  Created by Nikolai Lipski on 20.03.24.
//

import Foundation

struct Location: Codable, Hashable {
    let name: String
    let country: String
    let lat: Double
    let lon: Double
    
    static let mock: Location = Location(name: "Miami Beach",
                                         country: "USA",
                                         lat: 13.13,
                                         lon: 31.31)
}
