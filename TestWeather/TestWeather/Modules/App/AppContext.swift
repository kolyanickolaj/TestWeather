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
}

final class Context: AppContext {
    var weatherFetcher: WeatherFetcherProtocol = WeatherFetcher()
    var locationSearcher: LocationSearcherProtocol = LocationSearcher()
}
