//
//  StartViewModel.swift
//  TestWeather
//
//  Created by Nikolai Lipski on 20.03.24.
//

import Foundation

final class StartViewModel: ObservableObject {
    private let locationSearcher: LocationSearcherProtocol
    private let weatherFetcher: WeatherFetcherProtocol
    
    init(locationSearcher: LocationSearcherProtocol,
         weatherFetcher: WeatherFetcherProtocol)
    {
        self.locationSearcher = locationSearcher
        self.weatherFetcher = weatherFetcher
    }
    
    var errorText = ""
    
    @Published var textToSearch = ""
    @Published var searchHistory: [Location] = []
    @Published var searchResults: [Location] = []
    @Published var isProcessing = false
    @Published var isShowingAlert = false
    @Published var detailsDependency: DetailsDependency?
    
    func search() {
        guard !textToSearch.isEmpty else { return }
        
        isProcessing = true
        
        Task {
            do {
                let results = try await locationSearcher.searchLocations(textToSearch)
                
                DispatchQueue.main.async { [weak self] in
                    self?.isProcessing = false
                    self?.searchResults = results
                }
            } catch {
                DispatchQueue.main.async { [weak self] in
                    self?.isProcessing = false
                    self?.errorText = error.localizedDescription
                    self?.isShowingAlert = true
                }
            }
        }
    }
    
    func onTapSuggestion(_ suggestion: Location) {
        textToSearch = ""
        searchHistory.append(suggestion)
        searchResults = []
        getWeatherData(for: suggestion)
    }
    
    func onTapLocation(_ location: Location) {
        getWeatherData(for: location)
    }
    
    private func getWeatherData(for location: Location) {
        isProcessing = true
        
        Task {
            do {
                let data = try await weatherFetcher.getWeather(for: location)
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    
                    self.isProcessing = false
                    self.detailsDependency = DetailsDependency(weatherData: data,
                                                                weatherFetcher: self.weatherFetcher)
                }
            } catch {
                DispatchQueue.main.async { [weak self] in
                    self?.isProcessing = false
                    self?.errorText = error.localizedDescription
                    self?.isShowingAlert = true
                }
            }
        }
    }
}
