//
//  ReachabilityService.swift
//  TestWeather
//
//  Created by Nikolai Lipski on 22.03.24.
//

import Foundation
import Reachability

protocol ReachabilityServiceProtocol {
    var isReachable: Bool { get }
}

final class ReachabilityService: ReachabilityServiceProtocol {
    let reachability = try! Reachability()
    
    var isReachable: Bool {
        reachability.connection != .unavailable
    }
}
