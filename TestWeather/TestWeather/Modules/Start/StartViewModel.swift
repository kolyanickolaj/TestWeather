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
    private let reachabilityService: ReachabilityServiceProtocol
    
    init(locationSearcher: LocationSearcherProtocol,
         weatherFetcher: WeatherFetcherProtocol,
         reachabilityService: ReachabilityServiceProtocol)
    {
        self.locationSearcher = locationSearcher
        self.weatherFetcher = weatherFetcher
        self.reachabilityService = reachabilityService
    }
    
    var errorText = ""
    
    @Published var textToSearch = ""
    @Published var searchHistory: [Location] = []
    @Published var searchResults: [Location] = []
    @Published var isProcessing = false
    @Published var isShowingAlert = false
    @Published var detailsDependency: DetailsDependency?
    
    var formattedTextToSearch: String? {
        guard !textToSearch.isEmpty,
              !textToSearch.trimmingCharacters(in: .whitespaces).isEmpty
        else {
            return nil
        }
        
        return textToSearch
    }
    
    func search() {
        guard !textToSearch.isEmpty else { return }
        
        guard reachabilityService.isReachable else {
            showError("No Internet connection")
            return
        }
        
        guard !textToSearch.trimmingCharacters(in: .whitespaces).isEmpty else {
            showError("Enter valid location name")
            return
        }
        
        handleSearch()
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
    
    private func handleSearch() {
        guard let formattedTextToSearch else { return }
        
        isProcessing = true
        
        Task {
            do {
                let results = try await locationSearcher.searchLocations(formattedTextToSearch)
                
                DispatchQueue.main.async { [weak self] in
                    self?.isProcessing = false
                    self?.searchResults = results
                }
            } catch {
                DispatchQueue.main.async { [weak self] in
                    self?.isProcessing = false
                    self?.showError(error)
                }
            }
        }
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
                                                               weatherFetcher: self.weatherFetcher, 
                                                               reachabilityService: self.reachabilityService)
                }
            } catch {
                DispatchQueue.main.async { [weak self] in
                    self?.isProcessing = false
                    self?.showError(error)
                }
            }
        }
    }
    
    private func showError(_ error: Error) {
        if let error = error as? ApiError {
            showError(error.customDescription)
        } else {
            showError(error.localizedDescription)
        }
    }
    
    private func showError(_ error: String) {
        errorText = error
        isShowingAlert = true
    }
}
