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
    let icon: String
}
