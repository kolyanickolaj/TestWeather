//
//  DetailsViewModel.swift
//  TestWeather
//
//  Created by Nikolai Lipski on 20.03.24.
//

import SwiftUI

final class DetailsViewModel: ObservableObject {
    private let weatherFetcher: WeatherFetcherProtocol
    private let reachabilityService: ReachabilityServiceProtocol
    var errorText = ""
    
    @Published var isShowingAlert = false
    @Published var isCelsius = true
    @Published var image: Image?
    @Published var weatherData: WeatherData
    
    var iconURL: URL? {
        guard !weatherData.icon.isEmpty,
              !weatherData.icon.trimmingCharacters(in: .whitespaces).isEmpty
        else {
            return nil
        }
        
        return URL(string: Constants.OpenWeather.imageUrl(code: weatherData.icon))
    }
    
    init(weatherData: WeatherData,
         weatherFetcher: WeatherFetcherProtocol,
         reachabilityService: ReachabilityServiceProtocol)
    {
        self.weatherData = weatherData
        self.weatherFetcher = weatherFetcher
        self.reachabilityService = reachabilityService
    }
    
    func onAppear() {
        loadIcon()
    }
    
    func refresh() {
        getWeatherData(for: weatherData.location)
    }
    
    private func loadIcon() {
        guard reachabilityService.isReachable else {
            showError("No Internet connection")
            return
        }
        
        guard let iconURL else { return }

        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: iconURL),
                  let fetchedImage: UIImage = UIImage(data: data)
            else { return }
            
            DispatchQueue.main.async { [weak self] in
                self?.image = Image(uiImage: fetchedImage)
            }
        }
    }
    
    private func getWeatherData(for location: Location) {
        Task {
            do {
                let data = try await weatherFetcher.getWeather(for: location)
                DispatchQueue.main.async { [weak self] in
                    self?.weatherData = data
                }
            } catch {
                DispatchQueue.main.async { [weak self] in
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
