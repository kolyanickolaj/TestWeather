//
//  StartViewModel+Composition.swift
//  TestWeather
//
//  Created by Nikolai Lipski on 21.03.24.
//

import Foundation

extension StartViewModel {
    convenience init(context: AppContext) {
        self.init(
            locationSearcher: context.locationSearcher,
            weatherFetcher: context.weatherFetcher, 
            reachabilityService: context.reachabilityService)
    }
}
