//
//  SearchViewModel.swift
//  Search
//
//  Created by hoseinAlimoradi on 6/27/23.
//

import Combine
import Foundation

final class SearchViewModel: SearchViewModelProtocol {

    private enum Constants {
    }

    // MARK: - Properties
    var state: CurrentValueSubject<SearchViewModelState, Never>
    let searchAPI: SearchAPIProtocol
     
    // MARK: - Initialize
    init(configuration: SearchModule.Configuration) {
        searchAPI = configuration.searchAPI
        state = .init(.init())
    }

    func action(_ handler: SearchViewModelAction) {
        switch handler {
        case .search(let text):
            search(text)
        }
    }
 
    private func search(_ text: String?) {
        guard let text = text else { return }
        self.state.value = self.state.value.update(searchFetchState: SearchFetchState.loading)

        Task { [weak self] in
            guard let self = self else { return }
            do {
                let images =  try await self.searchAPI.search(text, nextPage: false)
                self.state.value = self.state.value.update(searchFetchState: SearchFetchState.idle, images: images)
            } catch {
                //TODO
                self.state.value = self.state.value.update(searchFetchState: SearchFetchState.idle, images: [])
            }
        }
    }
}




