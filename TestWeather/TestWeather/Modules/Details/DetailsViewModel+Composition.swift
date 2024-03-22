//
//  DetailsViewModel+Composition.swift
//  TestWeather
//
//  Created by Nikolai Lipski on 21.03.24.
//

import Foundation

struct DetailsDependency: Identifiable, Hashable {
    let id = UUID()
    
    static func == (lhs: DetailsDependency, rhs: DetailsDependency) -> Bool {
        lhs.weatherData == rhs.weatherData
    }
     
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id.uuidString)
    }
    
    let weatherData: WeatherData
    let weatherFetcher: WeatherFetcherProtocol
    let reachabilityService: ReachabilityServiceProtocol
}

extension DetailsViewModel {
    convenience init(dependency: DetailsDependency) {
        self.init(weatherData: dependency.weatherData,
                  weatherFetcher: dependency.weatherFetcher, 
                  reachabilityService: dependency.reachabilityService)
    }
}
