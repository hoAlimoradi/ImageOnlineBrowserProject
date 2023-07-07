//
//  SearchAPI.swift
//  Search
//
//  Created by hoseinAlimoradi on 6/27/23.
//

import Foundation
import Combine
import NetworkAPI
import CoreHaptics

protocol SearchAPIProtocol {
    func search(_ query: String, nextPage: Bool) async throws -> [ImageModel]
}

class SearchAPI: SearchAPIProtocol {

    enum TasksAPIError: Error {
        case invalidResponse
        case invalidSelf
    }
    private var cancelables = Set<AnyCancellable>()
    private let networkManager: HttpClientManagerProtocol
    
    @Published private (set) var curatedImages: Array<PSPhoto> = []
    @Published private (set) var searchImages: Array<PSPhoto> = []
    @Published private (set) var collectionImages: Array<PSPhoto> = []
    @Published private (set) var collectionCategories: Array<PSCollection> = []
    
    @Published var showNotification: Bool = false
    
     
    
    private var engine: CHHapticEngine?
    
    private var curatedPage = 1
    private var searchPage = 1
    private var categoriesPage = 1
    private var collectionPage = 1
    init(networkManager: HttpClientManagerProtocol = HttpClientManager.shared) {
        self.networkManager = networkManager
    } 

    func search(_ query: String, nextPage: Bool = false) async throws -> [ImageModel] {
        
        if nextPage { searchPage += 1 } else { searchPage = 1 }
        let results: PhotosResult = try await networkManager.searchPhotos(query,
                                                        orientation: nil,
                                                        size: nil,
                                                        color: nil,
                                                        locale: nil,
                                                        page: 1,
                                                        count: 10)
        if self.searchPage == 1 {
            searchImages = results.data
        } else {
            searchImages.append(contentsOf: results.data)
        }
        
        return mapper(searchImages) 
    }
    
    func mapper(_ images: [PSPhoto]) -> [ImageModel] {
        let imageModels = images.compactMap {
            ImageModel(id: $0.id,
                       width: $0.width,
                       height: $0.height,
                       url: $0.url,
                       photographer: $0.photographer,
                       photographerURL: $0.photographerURL,
                       photographerID: $0.photographerID,
                       averageColor: $0.averageColor,
                       source: $0.source,
                       alternateDescription: $0.alternateDescription)
        }
        return imageModels
    }
}

/*
 let mock1 = ImageModel(id: UUID().uuidString ,
                                name: "test 1",
                                description: "kjsdlkfjlk",
                                like: false)
 let mock2 = ImageModel(id: UUID().uuidString ,
                                name: "test 2",
                                description: "saaalsdsdkfjlk",
                                like: false)
 return [mock1, mock2]
 */
struct ImageModel1 {
    var id: String
    var name: String
    var description: String?
    var like: Bool
}
struct ImageModel  {

    /// The id of the photo.
    public var id: Int

    /// The real width of the photo in pixels.
    public var width: Int

    /// The real height of the photo in pixels
    public var height: Int

    /// The Pexels URL where the photo is located.
    public var url: String

    /// The name of the photographer who took the photo.
    public var photographer: String

    /// The URL of the photographer's Pexels profile.
    public var photographerURL: String

    /// The ID of the photographer.
    public var photographerID: Int

    /// The average color of the photo. Useful for a placeholder while the image loads.
    public var averageColor: String

    /// A collection of URLs of different image sizes that can be used to display this ``PSPhoto``.
    public var source: [Size.RawValue: String]

    /// Text description of the photo for use in the `alt` attribute (HTML).
    public var alternateDescription: String

    /// Keys for different image sizes that can be used to display this ``PSPhoto``
    public enum Size: String {

        /// The image without any size changes. It will be the same as
        /// the ``PSPhoto/width`` and ``PSPhoto/height`` attributes.
        case original

        /// the image resized to `940px X 650px @2x`
        case large2x

        /// the image resized to `940px X 650px`
        case large

        /// The image scaled proportionally so that it's new height is `350px`
        case medium

        /// The image scaled proportionally so that it's new height is `130px`
        case small

        /// The image cropped to `800px X 1200px`
        case portrait

        /// The image cropped to `1200px X 627px`
        case landscape

        /// The image cropped to `280px X 200px`
        case tiny
    }

}
