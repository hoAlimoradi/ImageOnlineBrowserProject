//
//  DetailsViewModel.swift
//  Detials
//
//  Created by hoseinAlimoradi on 7/9/23.
//
import Combine
import Foundation

final class DetailsViewModel: DetailsViewModelProtocol {

    private enum Constants {
    }

    // MARK: - Properties
    var state: CurrentValueSubject<DetailsViewModelState, Never>
    let detailsAPI: DetailsAPIProtocol
    private let categoryId: String
    // MARK: - Initialize
    init(configuration: DetailsModule.Configuration) {
        detailsAPI = configuration.detailsAPI
        categoryId = configuration.collectionCategoryId
        state = .init(.init())
    }

    func action(_ handler: DetailsViewModelAction) {
        switch handler {
        case .getphotos:
            getPhotos()
        case .getVideos:
            getVideos()
        }
    }
     
    private func getPhotos() {
        self.state.value = self.state.value.update(detailsFetchState: DetailsFetchState.loading)

        Task { [weak self] in
            guard let self = self else { return }
            do {
                let photoItems =  try await self.detailsAPI.getPhotos(page: 1, count: 30)
                self.state.value = self.state.value.update(detailsFetchState: DetailsFetchState.idle,
                                                           photoItems: photoItems)
            } catch {
                //TODO
                self.state.value = self.state.value.update(detailsFetchState: DetailsFetchState.idle,
                                                           photoItems: [])
            }
        }
    }
    
    private func getVideos() {
       self.state.value = self.state.value.update(detailsFetchState: DetailsFetchState.loading)

       Task { [weak self] in
           guard let self = self else { return }
           do {
               let videoItems =  try await self.detailsAPI.getVideos(for: categoryId,
                                                                     page: 1,
                                                                     count: 30)
               self.state.value = self.state.value.update(detailsFetchState: DetailsFetchState.idle,
                                                          videoItems: videoItems)
           } catch {
               //TODO
               self.state.value = self.state.value.update(detailsFetchState: DetailsFetchState.idle,
                                                          videoItems: [])
           }
       }
   }
}
