//
//  AppContext.swift
//  TestWeather
//
//  Created by Nikolai Lipski on 21.03.24.
//

import Foundation

protocol AppContext {
    var weatherFetcher: WeatherFetcherProtocol { get }
    var locationSearcher: LocationSearcherProtocol { get }
    var reachabilityService: ReachabilityServiceProtocol { get }
}

final class Context: AppContext {
    lazy var weatherFetcher: WeatherFetcherProtocol = WeatherFetcher()
    lazy var locationSearcher: LocationSearcherProtocol = LocationSearcher()
    lazy var reachabilityService: ReachabilityServiceProtocol = ReachabilityService()
}
