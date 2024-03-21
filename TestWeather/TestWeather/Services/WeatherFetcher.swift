//
//  WeatherFetcher.swift
//  TestWeather
//
//  Created by Nikolai Lipski on 20.03.24.
//

import Foundation

protocol WeatherFetcherProtocol {
    func getWeather(for location: Location) async throws -> WeatherData
}

final class WeatherFetcher: WeatherFetcherProtocol {
    private var fetcher: GenericAPI = Fetcher()
    
    func getWeather(for location: Location) async throws -> WeatherData {
        guard let url = URL(string: Constants.OpenWeather.getWeatherUrl(lat: location.lat, lon: location.lon)) else {
            throw ApiError.requestFailed(description: "Invalid URL")
        }
        
        let fetchedData: Data = try await fetcher.fetchData(request: URLRequest(url: url))
        
        return try parseData(fetchedData, location: location)
    }
    
    private func parseData(_ data: Data, location: Location) throws -> WeatherData {
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
            throw ApiError.failedSerialization
        }
        
        guard let weatherDictsArray = dictionary["weather"] as? [[String: Any]],
              let weatherDict = weatherDictsArray.first,
              let mainWeather = weatherDict["main"] as? String,
              let mainDescription = weatherDict["description"] as? String,
              let mainIcon = weatherDict["icon"] as? String,
              let windDict = dictionary["wind"] as? [String: Any],
              let wind = windDict["speed"] as? Double,
              let mainDict = dictionary["main"] as? [String: Any],
              let temperature = mainDict["temp"] as? Double,
              let humidity = mainDict["humidity"] as? Double,
              let feelsLikeTemperature = mainDict["feels_like"] as? Double
        else {
            throw ApiError.jsonParsingFailure
        }
        
        return WeatherData(location: location,
                           description: "\(mainWeather) - \(mainDescription)",
                           temperature: temperature,
                           feelsLikeTemperature: feelsLikeTemperature,
                           humidity: humidity,
                           windSpeed: wind,
                           icon: mainIcon)
    }
}
