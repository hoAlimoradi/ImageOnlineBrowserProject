//
//  DetailsViewModelProtocol.swift
//  Detials
//
//  Created by hoseinAlimoradi on 7/9/23.
//

import Foundation
import Combine

protocol DetailsViewModelProtocol {
    var state: CurrentValueSubject<DetailsViewModelState, Never> { get }
    func action(_ handler: DetailsViewModelAction)
}

enum DetailsFetchState: Equatable {
    case idle
    case loading
    case success(String?)
    case failed(Error)

    static func == (lhs: DetailsFetchState, rhs: DetailsFetchState) -> Bool {
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

enum DetailsRouteAction {
    case pop
}

struct DetailsViewModelState {
    let route: DetailsRouteAction?
    let detailsFetchState: DetailsFetchState?
    let photoItems: [PhotoItem]?
    let videoItems: [VideoItem]?

    init(route: DetailsRouteAction? = nil,
         detailsFetchState: DetailsFetchState? = nil,
         photoItems: [PhotoItem]? = nil,
         videoItems: [VideoItem]? = nil) {
        self.route = route
        self.detailsFetchState = detailsFetchState ?? .idle
        self.photoItems = photoItems
        self.videoItems = videoItems
    }

    func update(
        route: DetailsRouteAction? = nil,
        detailsFetchState: DetailsFetchState? = nil,
        photoItems: [PhotoItem]? = nil,
        videoItems: [VideoItem]? = nil) -> Self {
            .init(route: route ?? self.route,
                  detailsFetchState: detailsFetchState ?? self.detailsFetchState,
                  photoItems: photoItems ?? self.photoItems,
                  videoItems: videoItems ?? self.videoItems)
        }
}

enum DetailsViewModelAction {
    case getphotos
    case getVideos
}


