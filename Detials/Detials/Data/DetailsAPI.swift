//
//  DetailsAPI.swift
//  Detials
//
//  Created by hoseinAlimoradi on 7/9/23.
//
import Foundation
import Combine
import NetworkAPI

protocol DetailsAPIProtocol {
    func getPhotos(
        page: Int,
        count: Int
    ) async throws -> [PhotoItem]
    
    func getVideos(
        for categoryID: String,
        page: Int,
        count: Int
    ) async throws -> [VideoItem]
}

class DetailsAPI: DetailsAPIProtocol {

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
    
    func getPhotos(page: Int, count: Int) async throws -> [PhotoItem] {
        let results: PhotosResult = try await networkManager.getPhotos(page: 1,
                                                                       count: 15)
        return mapperToPhotos(results.data)
    }
    
    func getVideos(for categoryID: String, page: Int, count: Int) async throws -> [VideoItem] {
        let results: VideosResult = try await networkManager.getVideos(for: categoryID,
                                                                      page: 1,
                                                                      count: 50)
        
        return mapperToVideos(results.data)
    }
     
    //MARK: - mapperToPhotos
    private func mapperToPhotos(_ photos: [PSPhoto]) -> [PhotoItem] {
        let photoItems = photos.compactMap {
            PhotoItem(id: $0.id,
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
        return photoItems
    }
    
    //MARK: - mapperToVideos
    private func mapperToVideos(_ videos: [PSVideo]) -> [VideoItem] {
        let videoItems = videos.compactMap {
            VideoItem(id: $0.id,
                      width: $0.width,
                      height: $0.height,
                      url: $0.url,
                      image: $0.image,
                      duration: $0.duration,
                      user:  mapperVideographer($0.user),
                      videoFiles: mapperVideoFile($0.videoFiles),
                      videoPictures: mapperVideoPictures($0.videoPictures))
        }
        return videoItems
    }
    
    private func mapperVideographer(_ videographer: NetworkAPI.PSVideo.Videographer) -> VideoItem.VideographerItem {
        let videoItem = VideoItem.VideographerItem(id: videographer.id,
                                                    name: videographer.name,
                                                    url: videographer.url)
        return videoItem
    }
    
    private func mapperVideoFile(_ videographer: [NetworkAPI.PSVideo.File]) -> [VideoItem.FileItem] {
        let videoFileItems = videographer.compactMap {
            VideoItem.FileItem(id: $0.id,
                               quality: mapperToVideoItemFileItemQualityItem($0.quality),
                               fileType: $0.fileType,
                               link: $0.link)
        }
        return videoFileItems
    }
    
    private func mapperToVideoItemFileItemQualityItem(_ quality: NetworkAPI.PSVideo.File.Quality) -> VideoItem.FileItem.QualityItem {
        switch quality {
        case .hd:
            return VideoItem.FileItem.QualityItem.hd
        case .hls:
            return VideoItem.FileItem.QualityItem.hls
        case .sd:
            return VideoItem.FileItem.QualityItem.sd
        }
    }
    
    private func mapperVideoPictures(_ videoPictures: [NetworkAPI.PSVideo.Preview]) -> [VideoItem.PreviewItem] {
        let videoPictureItems = videoPictures.compactMap {
            VideoItem.PreviewItem(id: $0.id,
                                  link: $0.link,
                                  index: $0.index)
        }
        return videoPictureItems
    }
}


//MARK: - Photo Model
public struct PhotoItem {
    public var id: Int
    public var width: Int
    public var height: Int
    public var url: String
    public var photographer: String
    public var photographerURL: String
    public var photographerID: Int
    public var averageColor: String
    public var source: [Size.RawValue: String]
    public var alternateDescription: String
    public enum Size: String {
        case original
        case large2x
        case large
        case medium
        case small
        case portrait
        case landscape
        case tiny
    } 
}

//MARK: - Video Model 
public struct VideoItem {
    public var id: Int
    public var width: Int
    public var height: Int
    public var url: String
    public var image: String
    public var duration: Int
    public var user: VideographerItem
    public var videoFiles: [FileItem]
    public var videoPictures: [PreviewItem]
    public struct VideographerItem {
        public var id: Int
        public var name: String
        public var url: String
    }
 
    public struct FileItem {
        public var id: Int
        public var quality: QualityItem
        public var fileType: String
        public var width: Int?
        public var height: Int?
        public var fps: Double?
        public var link: String
        public enum QualityItem: String {
            case hd, sd, hls
        }
    }
    
    public struct PreviewItem {
        public var id: Int
        public var link: String
        public var index: Int
    }
}
