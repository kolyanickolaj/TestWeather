//
//  StartViewModel.swift
//  TestWeather
//
//  Created by Nikolai Lipski on 20.03.24.
//

import Foundation

final class StartViewModel: ObservableObject {
    private let locationSearcher = LocationSearcher()
    
    @Published var textToSearch = ""
    @Published var searchHistory: [Location] = []
    @Published var searchResults: [Location] = []
    @Published var isProcessing = false
    
    func search() {
        isProcessing = true
        Task {
            let f = try await locationSearcher.searchLocations(textToSearch)
            print(f)
            DispatchQueue.main.async { [weak self] in
                self?.isProcessing = false
                self?.searchResults = f
            }
            
        }
    }
}
