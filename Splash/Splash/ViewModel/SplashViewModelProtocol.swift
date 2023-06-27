//
//  SplashViewModelProtocol.swift
//  Splash
//
//  Created by hoseinAlimoradi on 6/23/23.
//

import Foundation
import Combine
 
protocol SplashViewModelProtocol {
    var state: CurrentValueSubject<SplashViewModelState, Never> { get }
    func action(_ handler: SplashViewModelAction)
}

enum SplashFetchState: Equatable {
    case idle
    case loading
    case success(String?)
    case failed(Error)

    static func == (lhs: SplashFetchState, rhs: SplashFetchState) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle), (.loading, .loading):
            return true
        case let (.success(lhs), .success(rhs)):
            return lhs == rhs
        case let (.failed(lhs), .failed(rhs)):
            return lhs.localizedDescription == rhs.localizedDescription
        default: return false
        }
    }
}

enum SplashRouteAction {
    case home
}

struct SplashViewModelState {
    let route: SplashRouteAction?
    let splashFetchState: SplashFetchState?
    let version: String?

    init(route: SplashRouteAction? = nil,
         splashFetchState: SplashFetchState? = nil,
         version: String? = nil) {
        self.route = route
        self.splashFetchState = splashFetchState ?? .idle
        self.version = version
    }

    func update(
        route: SplashRouteAction? = nil,
        splashFetchState: SplashFetchState? = nil,
        version: String? = nil) -> Self {
            .init(route: route ?? self.route,
                  splashFetchState: splashFetchState ?? self.splashFetchState,
                  version: version ?? self.version)
        }
}

enum SplashViewModelAction {
    case getVersion
} 
