//
//  WeatherData.swift
//  TestWeather
//
//  Created by Nikolai Lipski on 20.03.24.
//

import Foundation

struct WeatherData: Codable, Hashable, Identifiable {
    var id = UUID()
    
    let location: Location
    let description: String
    let temperature: Double
    let feelsLikeTemperature: Double
    let humidity: Double
    let windSpeed: Double
    var icon: String
    
    static let mock: WeatherData = WeatherData(location: Location.mock,
                                               description: "some Description",
                                               temperature: 13,
                                               feelsLikeTemperature: 31,
                                               humidity: 13,
                                               windSpeed: 31,
                                               icon: "x10")
}
