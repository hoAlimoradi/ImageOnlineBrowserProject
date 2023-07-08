//
//  HomeViewModelProtocol.swift
//  Home
//
//  Created by hoseinAlimoradi on 7/8/23.
//

import Foundation
import Combine

protocol HomeViewModelProtocol {
    var state: CurrentValueSubject<HomeViewModelState, Never> { get }
    func action(_ handler: HomeViewModelAction)
}

enum HomeFetchState: Equatable {
    case idle
    case loading
    case success(String?)
    case failed(Error)

    static func == (lhs: HomeFetchState, rhs: HomeFetchState) -> Bool {
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

enum HomeRouteAction {
    case details(CollectionItem)
}

struct HomeViewModelState {
    let route: HomeRouteAction?
    let homeFetchState: HomeFetchState?
    let collectionItems: [CollectionItem]?

    init(route: HomeRouteAction? = nil,
         homeFetchState: HomeFetchState? = nil,
         collectionItems: [CollectionItem]? = nil) {
        self.route = route
        self.homeFetchState = homeFetchState ?? .idle
        self.collectionItems = collectionItems
    }

    func update(
        route: HomeRouteAction? = nil,
        homeFetchState: HomeFetchState? = nil,
        collectionItems: [CollectionItem]? = nil) -> Self {
            .init(route: route ?? self.route,
                  homeFetchState: homeFetchState ?? self.homeFetchState,
                  collectionItems: collectionItems ?? self.collectionItems)
        }
}

enum HomeViewModelAction {
    case getCollections
    case details(CollectionItem)
}

