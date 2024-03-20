//
//  Constants.swift
//  TestWeather
//
//  Created by Nikolai Lipski on 20.03.24.
//

import Foundation

struct Constants {
    struct OpenWeather {
        static let apiKey = "381af249c5400aa98d6981a14533b73a"
        static let searchLimit = 10
        static func searchLocationUrl(location: String) -> String {
            "https://api.openweathermap.org/geo/1.0/direct?q=\(location)&limit=\(searchLimit)&appid=\(apiKey)"
        }
    }
    
    
}
