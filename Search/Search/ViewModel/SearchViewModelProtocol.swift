//
//  SearchViewModelProtocol.swift
//  Search
//
//  Created by hoseinAlimoradi on 6/27/23.
//

import Foundation
import Combine

protocol SearchViewModelProtocol {
    var state: CurrentValueSubject<SearchViewModelState, Never> { get }
    func action(_ handler: SearchViewModelAction)
}

enum SearchFetchState: Equatable {
    case idle
    case loading
    case success(String?)
    case failed(Error)

    static func == (lhs: SearchFetchState, rhs: SearchFetchState) -> Bool {
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

enum SearchRouteAction {
    case details(String)
}

struct SearchViewModelState {
    let route: SearchRouteAction?
    let searchFetchState: SearchFetchState?
    let images: [ImageModel]?

    init(route: SearchRouteAction? = nil,
         searchFetchState: SearchFetchState? = nil,
         images: [ImageModel]? = nil) {
        self.route = route
        self.searchFetchState = searchFetchState ?? .idle
        self.images = images
    }

    func update(
        route: SearchRouteAction? = nil,
        searchFetchState: SearchFetchState? = nil,
        images: [ImageModel]? = nil) -> Self {
            .init(route: route ?? self.route,
                  searchFetchState: searchFetchState ?? self.searchFetchState,
                  images: images ?? self.images)
        }
}

enum SearchViewModelAction {
    case search(String?)
}
