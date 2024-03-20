//
//  TestWeatherApp.swift
//  TestWeather
//
//  Created by Nikolai Lipski on 20.03.24.
//

import SwiftUI

@main
struct TestWeatherApp: App {
    var body: some Scene {
        WindowGroup {
            StartView(viewModel: StartViewModel())
        }
    }
}
