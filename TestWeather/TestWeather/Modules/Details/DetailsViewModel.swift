//
//  DetailsViewModel.swift
//  TestWeather
//
//  Created by Nikolai Lipski on 20.03.24.
//

import SwiftUI

final class DetailsViewModel: ObservableObject {
    private let weatherFetcher: WeatherFetcherProtocol
    var errorText = ""
    
    @Published var isShowingAlert = false
    @Published var isCelsius = true
    @Published var image: Image?
    
    var weatherData: WeatherData
    
    init(weatherData: WeatherData,
         weatherFetcher: WeatherFetcherProtocol)
    {
        self.weatherData = weatherData
        self.weatherFetcher = weatherFetcher
    }
    
    func onAppear() {
        loadIcon()
    }
    
    func refresh() {
        getWeatherData(for: weatherData.location)
    }
    
    private func loadIcon() {
        guard let url = URL(string: Constants.OpenWeather.imageUrl(code: weatherData.icon)) else { return }

        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: url),
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
                    self?.errorText = error.localizedDescription
                    self?.isShowingAlert = true
                }
            }
        }
    }
}
