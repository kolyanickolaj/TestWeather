//
//  DetailsView.swift
//  TestWeather
//
//  Created by Nikolai Lipski on 20.03.24.
//

import SwiftUI

struct DetailsView: View {
    @StateObject var viewModel: DetailsViewModel
    
    private var model: WeatherData {
        viewModel.weatherData
    }
    
    var body: some View {
        VStack {
            List {
                HStack {
                    Spacer()
                    
                    if let image = viewModel.image {
                        image
                            .shadow(radius: 20)
                        
                        Spacer()
                    }
                    
                    Text("\(temperature)")
                        .font(.system(size: 40, weight: .bold))
                    
                    Button {
                        viewModel.isCelsius.toggle()
                    } label: {
                        Text("\(celsiusSign)")
                            .foregroundColor(viewModel.isCelsius ? .black : .gray)
                            .font(.system(size: 40, weight: .bold))
                        + Text("/")
                            .foregroundColor(.black)
                            .font(.system(size: 40, weight: .bold))
                        + Text("\(fahrenheitSign)")
                            .foregroundColor(viewModel.isCelsius ? .gray : .black)
                            .font(.system(size: 40, weight: .bold))
                    }
                    
                    Spacer()
                }
                .frame(height: 100)
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets())
                
                Text(model.description)
                    .font(.system(size: 30, weight: .semibold))
                    .frame(maxWidth: .infinity)
                    .frame(alignment: .center)
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets())
                
                WeatherDescriptionView(title: "Humidity",
                                       description: .constant("\(model.humidity)%"))
                .frame(height: 40)
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets())
                
                WeatherDescriptionView(title: "Wind",
                                       description: .constant("\(model.windSpeed) m/s"))
                .frame(height: 40)
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets())
                
                WeatherDescriptionView(title: "Feels Like",
                                       description: .constant("\(feelsLikeTemperature)\(temperatureSign)") )
                .frame(height: 40)
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets())
            }
            .listStyle(.plain)
            .refreshable {
                viewModel.refresh()
            }
            
            Spacer()
        }
        .onAppear {
            viewModel.onAppear()
        }
        .alert(viewModel.errorText, isPresented: $viewModel.isShowingAlert) {
            Button("OK", role: .cancel) { }
        }
        .navigationTitle("\(model.location.name), \(model.location.country)")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private var temperature: Int {
        if viewModel.isCelsius {
            return Int(model.temperature)
        } else {
            return Int(model.temperature * 9 / 5 + 32)
        }
    }
    
    private var feelsLikeTemperature: Int {
        if viewModel.isCelsius {
            return Int(model.temperature)
        } else {
            return Int(model.temperature * 9 / 5 + 32)
        }
    }
    
    private var temperatureSign: String {
        viewModel.isCelsius ? celsiusSign : fahrenheitSign
    }
    
    private var celsiusSign: String {
        "\u{00B0}" + "C"
    }
    
    private var fahrenheitSign: String {
        "\u{00B0}" + "F"
    }
}

#Preview {
    DetailsView(
        viewModel:
            DetailsViewModel(
                weatherData:
                    WeatherData(
                        location: Location(name: "New York",
                                           country: "USA",
                                           lat: 13,
                                           lon: 13),
                        description: "Windy",
                        temperature: 13,
                        feelsLikeTemperature: 13,
                        humidity: 80,
                        windSpeed: 13,
                        icon: ""), 
                weatherFetcher: WeatherFetcher()))
}
