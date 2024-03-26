//
//  DetailsViewModelTests.swift
//  TestWeatherTests
//
//  Created by Nikolai Lipski on 25.03.24.
//

import XCTest
@testable import TestWeather

final class DetailsViewModelTests: XCTestCase {
    func testInitialState() {
        let context = Context()
        let dependency = DetailsDependency(weatherData: WeatherData.mock,
                                           weatherFetcher: context.weatherFetcher,
                                           reachabilityService: context.reachabilityService)
        let viewModel = DetailsViewModel(dependency: dependency)
        
        XCTAssertFalse(viewModel.isShowingAlert)
        XCTAssertNil(viewModel.image)
        XCTAssertTrue(viewModel.isCelsius)
        XCTAssertTrue(viewModel.errorText.isEmpty)
    }

    func testShouldLoadIcon() {
        let context = Context()
        let dependency = DetailsDependency(weatherData: WeatherData.mock,
                                           weatherFetcher: context.weatherFetcher,
                                           reachabilityService: context.reachabilityService)
        let viewModel = DetailsViewModel(dependency: dependency)
        
        XCTAssertNotNil(viewModel.iconURL)
    }

    func testShouldNotLoadEmptyIcon() {
        let context = Context()
        var weatherData = WeatherData.mock
        weatherData.icon = ""
        let dependency = DetailsDependency(weatherData: weatherData,
                                           weatherFetcher: context.weatherFetcher,
                                           reachabilityService: context.reachabilityService)
        let viewModel = DetailsViewModel(dependency: dependency)
        
        XCTAssertNil(viewModel.iconURL)
    }
    
    func testShouldNotLoadSpacesIcon() {
        let context = Context()
        var weatherData = WeatherData.mock
        weatherData.icon = "   "
        let dependency = DetailsDependency(weatherData: weatherData,
                                           weatherFetcher: context.weatherFetcher,
                                           reachabilityService: context.reachabilityService)
        let viewModel = DetailsViewModel(dependency: dependency)
        
        XCTAssertNil(viewModel.iconURL)
    }
    
}
