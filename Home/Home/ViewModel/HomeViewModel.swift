//
//  HomeViewModel.swift
//  Home
//
//  Created by hoseinAlimoradi on 7/8/23.
//

import Combine
import Foundation

final class HomeViewModel: HomeViewModelProtocol {

    private enum Constants {
    }

    // MARK: - Properties
    var state: CurrentValueSubject<HomeViewModelState, Never>
    let homeAPI: HomeAPIProtocol
     
    private var collections = [CollectionItem]()
    // MARK: - Initialize
    init(configuration: HomeModule.Configuration) {
        homeAPI = configuration.homeAPI
        state = .init(.init())
    }

    func action(_ handler: HomeViewModelAction) {
        switch handler {
        case .getCollections:
            getCollections()
        case .details(let index):
            details(index)
        }
    }
     
    private func getCollections() {
        self.state.value = self.state.value.update(homeFetchState: HomeFetchState.loading)

        Task { [weak self] in
            guard let self = self else { return }
            do {
                collections = try await self.homeAPI.getCollections()
                self.state.value = self.state.value.update(homeFetchState: HomeFetchState.idle,
                                                           collectionItems: collections)
            } catch {
                //TODO
                self.state.value = self.state.value.update(homeFetchState: HomeFetchState.idle,
                                                           collectionItems: [])
            }
        }
    }
     
    private func details(_ index: Int) {
        guard let id = collections.first?.id, let title = collections.first?.title else {
            return
        }
        self.state.value = self.state.value.update(route: .details(id, title),
                                                   homeFetchState: HomeFetchState.idle)
   }
}





