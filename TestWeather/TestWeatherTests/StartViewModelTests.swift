//
//  StartViewModelTests.swift
//  TestWeatherTests
//
//  Created by Nikolai Lipski on 25.03.24.
//

import XCTest
@testable import TestWeather

final class StartViewModelTests: XCTestCase {
    func testInitialState() {
        let viewModel = StartViewModel(context: Context())
        
        XCTAssertFalse(viewModel.isProcessing)
        XCTAssertFalse(viewModel.isShowingAlert)
        XCTAssertNil(viewModel.detailsDependency)
        XCTAssertNil(viewModel.formattedTextToSearch)
        XCTAssertTrue(viewModel.searchResults.isEmpty)
        XCTAssertTrue(viewModel.errorText.isEmpty)
    }
    
    func testShouldSearch() {
        let viewModel = StartViewModel(context: Context())
        viewModel.textToSearch = "Minsk"
        
        XCTAssertNotNil(viewModel.formattedTextToSearch)
    }

    func testShouldNotSearchEmpty() {
        let viewModel = StartViewModel(context: Context())
        viewModel.textToSearch = ""
        
        XCTAssertNil(viewModel.formattedTextToSearch)
    }
    
    func testShouldNotSearchSpaces() {
        let viewModel = StartViewModel(context: Context())
        viewModel.textToSearch = "    "
        
        XCTAssertNil(viewModel.formattedTextToSearch)
    }
}
