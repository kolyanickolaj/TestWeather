//
//  LocationSearcher.swift
//  TestWeather
//
//  Created by Nikolai Lipski on 20.03.24.
//

import Foundation
import Combine

protocol LocationSearcherProtocol {
    func searchLocations(_ location: String) async throws -> [Location]
//    associatedtype Request
//    associatedtype Response: Codable

//    func fetch(_ request: URLRequest, queryItems: [String: String]) async throws -> Codable
//    func fetchData(_ request: URLSession, queryItems: [String: String]) async throws -> Data
}

final class LocationSearcher: LocationSearcherProtocol {
    private var fetcher: GenericAPI = Fetcher()
    
    func searchLocations(_ location: String) async throws -> [Location] {
        guard let url = URL(string: Constants.OpenWeather.searchLocationUrl(location: location)) else {
            throw ApiError.requestFailed(description: "Invalid URL")
        }
        
        let result: [Location] = try await fetcher.fetch(request: URLRequest(url: url))
        return result
    }
    
}
