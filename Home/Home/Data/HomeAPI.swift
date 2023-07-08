//
//  HomeAPI.swift
//  Home
//
//  Created by hoseinAlimoradi on 7/8/23.
//
import Foundation
import Combine
import NetworkAPI 

protocol HomeAPIProtocol {
    func getCollections() async throws -> [CollectionItem]
}

class HomeAPI: HomeAPIProtocol {

    enum HomeAPIError: Error {
        case invalidResponse
        case invalidSelf
    }
    private var cancelables = Set<AnyCancellable>()
    private let networkManager: HttpClientManagerProtocol
    
    private var curatedPage = 1
    private var searchPage = 1
    private var categoriesPage = 1
    private var collectionPage = 1
    
    init(networkManager: HttpClientManagerProtocol = HttpClientManager.shared) {
        self.networkManager = networkManager
    }
    
    func getCollections() async throws -> [CollectionItem] {
        //if nextPage { searchPage += 1 } else { searchPage = 1 }
        let results: CollectionResult = try await networkManager.getCollections(page: 1,
                                                                            count: 80)
        
        return mapper(results.data)
    }
    
    private func mapper(_ collections: [PSCollection]) -> [CollectionItem] {
        let collectionItems = collections.compactMap {
            CollectionItem(id: $0.id,
                           title: $0.title,
                           description: $0.description,
                           isPrivate: $0.isPrivate,
                           mediaCount: $0.mediaCount,
                           photosCount: $0.photosCount,
                           videosCount: $0.videosCount)
             
        }
        return collectionItems
    }
}


//MARK: - Collection Model
public struct CollectionItem {
    public var id: String
    public var title: String
    public var description: String
    public var isPrivate: Bool
    public var mediaCount: Int
    public var photosCount: Int
    public var videosCount: Int
}
