//
//  HttpClientManager.swift
//  NetworkAPI
//
//  Created by hoseinAlimoradi on 6/30/23.
//

import Foundation
import Combine

public protocol HttpClientManagerProtocol {
    func getPhoto(by id: Int) async throws -> PhotoResult
    
    func getPhotos(
        page: Int,
        count: Int
    ) async throws -> PhotosResult
    
    func searchPhotos(
        _ query: String,
        orientation: PSOrientation?,
        size: PSSize?,
        color: PSColor?,
        locale: PSLocale?,
        page: Int,
        count: Int
    ) async throws -> PhotosResult
    
    func getPhotos(
        for categoryID: CategoryID,
        page: Int,
        count: Int
    ) async throws -> PhotosResult
    
    func getVideo(by id: Int) async throws -> VideoResult
    
    func getPopularVideos(
        minimumWidth: Int?,
        minimumHeight: Int?,
        minimumDuration: Int?,
        maximumDuration: Int?,
        page: Int,
        count: Int
    ) async throws -> VideosResult
    
    func searchVideos(
        _ query: String,
        orientation: PSOrientation?,
        size: PSSize?,
        locale: PSLocale?,
        page: Int,
        count: Int
    ) async throws -> VideosResult
    
    func getVideos(
        for categoryID: CategoryID,
        page: Int,
        count: Int
    ) async throws -> VideosResult
    
    func getCollections(
        page: Int,
        count: Int
    ) async throws -> CollectionResult
    
}

/// A String representing a category id.
public typealias CategoryID = String

//MARK: -- HttpClientManager
/// A  class for making API calls to the Pexels.com REST API.
public final class HttpClientManager: HttpClientManagerProtocol {
    
    //MARK: -- endpoints Enum
    /// A collection of API endpoints/routes.
    enum API {

        private static var basePath: String = "https://api.pexels.com/"

        private static var version: String = "v1"
        private static var videos: String = "videos"

        static var featuredCollections: String {
            URL(string: basePath)!
                .appendingPathComponent(version)
                .appendingPathComponent("collections")
                .appendingPathComponent("featured")
                .absoluteString
        }

        static func collections(_ id: String) -> String {
            URL(string: basePath)!
                .appendingPathComponent(version)
                .appendingPathComponent("collections")
                .appendingPathComponent(id)
                .absoluteString
        }

        static var searchPhotos: String {
            URL(string: basePath)!
                .appendingPathComponent(version)
                .appendingPathComponent("search")
                .absoluteString
        }

        static var curatedPhotos: String {
            URL(string: basePath)!
                .appendingPathComponent(version)
                .appendingPathComponent("curated")
                .absoluteString
        }

        static func photoByID(_ id: Int) -> String {
            URL(string: basePath)!
                .appendingPathComponent(version)
                .appendingPathComponent("photos")
                .appendingPathComponent(id.string)
                .absoluteString
        }

        static var searchVideos: String {
            URL(string: basePath)!
                .appendingPathComponent(videos)
                .appendingPathComponent("search")
                .absoluteString
        }

        static var popularVideos: String {
            URL(string: basePath)!
                .appendingPathComponent(videos)
                .appendingPathComponent("popular")
                .absoluteString
        }

        static func videoByID(_ id: Int) -> String {
            URL(string: basePath)!
                .appendingPathComponent(videos)
                .appendingPathComponent("videos")
                .appendingPathComponent(id.string)
                .absoluteString
        }
    }
    //MARK: -- HttpClientManager Error Enum
    /// Error Type indicating why an operation has failed 
    /// To print out the error just call its ``description`` property.
    public enum HttpClientManagerAPIError: Error, Equatable {

        /// A string describing the error.
        public typealias ErrorDescription = String

        /// A generic error with a description.
        case generic(ErrorDescription)

        /// An error indicating that no API Key was set.
        case noAPIKey

        /// An error indicating that no content (photos, videos, media) was returned.
        case noContent

        /// An error indicating a bad URL request. Passes a description of the url.
        case badURL(ErrorDescription)

        /// An error indicating there was no response from the server.
        case noResponse(ErrorDescription)

        /// An error indicating a non `2**` HTTP response.
        case httpResponse(Int)

        /// Retrieve the description for this error.
        public var description: String {
            switch self {
            case .generic(let description):
                return "Generic Error: \(description)"
            case .noAPIKey:
                return "No API key was set. Call `setup(apiKey:logLevel:)` before making a request"
            case .noContent:
                return "No content was found"
            case .badURL(let description):
                return "Not a valid URL: \(description)"
            case .noResponse(let description):
                return "No response from server: \(description)"
            case .httpResponse(let code):
                return "HTTP Error. Status code: \(code)"
            }
        }
    }
    //MARK: --
    let urlSession: URLSession

    internal init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }

    /// A String representing a category id.
    //public typealias CategoryID = String
 
    /// Result type for a generic type of `<T>`.
    //internal typealias PSResult<T> = Result<(data: T, response: HTTPURLResponse), HttpClientManagerAPIError>

    /// The singleton instance of ``PexelsSwift``
    public static let shared: HttpClientManager = .init()

    /// The HTTP-Header field for the API Key
    internal let apiHeader: String = "Authorization"

    /// The API key = R3iB8Z1aIHj5ZKYI4LksTDUiPobseCbBNtnE35x2LLFzzmFTJZzhLK3w
    ///
    /// Set through ``setAPIKey(_:)``.
    internal var apiKey: String = "R3iB8Z1aIHj5ZKYI4LksTDUiPobseCbBNtnE35x2LLFzzmFTJZzhLK3w"

    /// An instance of ``PSLogger``
    public var logger: PSLogger = .init()

    // MARK: - Public Methods

    /// Set the API key to make API Queries.
    ///
    /// An API Key can be obtained from [here](https://www.pexels.com/api/)
    /// - Attention: The `apiKey` must not be empty!
    /// - Parameters:
    ///   - apiKey: The API Key.
    ///   - logLevel: The `logLevel` to use. Defaults to ``PSLogLevel/info``.
    public func setup(apiKey: String, logLevel: PSLogLevel = .info) {
        self.apiKey = apiKey
        self.logger.setLogLevel(logLevel)
        logger.message("Setup Pexels-Swift complete")
    }

    /// Holds the most recent values for Rate Limit statistics.
    ///
    /// See <doc:Rate-Limits> for more information.
    public private(set) var rateLimit: RateLimit = .init()

    // MARK: - Internal Methods

    // MARK: Fetch Photos
    /// Fetch ``PSPhoto`` from [`URL`](https://developer.apple.com/documentation/foundation/url)
    /// - Parameter url: The URL to fetch from.
    /// - Returns: A result type of ``PhotosResult``
    internal func fetchPhotos(url: URL) async throws -> PhotosResult {
        let contentResultsPhoto : ContentResults<PSPhoto> = try await apiCall(url: url)
        
        let pagingInfo = PSPagingInfo(
            page: contentResultsPhoto.page,
            perPage: contentResultsPhoto.perPage,
            totalResults: contentResultsPhoto.totalResults,
            previousPage: contentResultsPhoto.previousPage,
            nextPage: contentResultsPhoto.nextPage
        )
        if let photos = contentResultsPhoto.photos {
            return PhotosResult(data: photos, paging: pagingInfo)
        } else if let media = contentResultsPhoto.media {
            return PhotosResult(data: media, paging: pagingInfo)
        } else {
            logger.error(HttpClientManagerAPIError.noContent)
            throw HttpClientManagerAPIError.noContent
        }
    }

    
    // MARK: Fetch Photo
    /// Fetch ``PSPhoto`` from [`URL`](https://developer.apple.com/documentation/foundation/url)
    /// - Parameter url: The URL to fetch from.
    /// - Returns: A result type of ``PhotosResult``
    internal func fetchPhoto(url: URL) async throws -> PhotoResult {
        let contentResultsPhoto : ContentResults<PSPhoto> = try await apiCall(url: url)
        
        let pagingInfo = PSPagingInfo(
            page: contentResultsPhoto.page,
            perPage: contentResultsPhoto.perPage,
            totalResults: contentResultsPhoto.totalResults,
            previousPage: contentResultsPhoto.previousPage,
            nextPage: contentResultsPhoto.nextPage
        )
        if let photos = contentResultsPhoto.photos?.first {
            return PhotoResult(data: photos, paging: pagingInfo)
        } else if let media = contentResultsPhoto.media?.first {
            return PhotoResult(data: media, paging: pagingInfo)
        } else {
            logger.error(HttpClientManagerAPIError.noContent)
            throw HttpClientManagerAPIError.noContent
        }
    }

    // MARK: Fetch Videos
    /// Fetch ``PSVideo`` from [`URL`](https://developer.apple.com/documentation/foundation/url)
    /// - Parameter url: The URL to fetch from.
    /// - Returns: A result type of ``VideosResult``
    internal func fetchVideos(url: URL) async throws -> VideosResult {
        let contentResultsVideo : ContentResults<PSVideo> = try await apiCall(url: url)
        
        let pagingInfo = PSPagingInfo(
            page: contentResultsVideo.page,
            perPage: contentResultsVideo.perPage,
            totalResults: contentResultsVideo.totalResults,
            previousPage: contentResultsVideo.previousPage,
            nextPage: contentResultsVideo.nextPage
        )
        if let videos = contentResultsVideo.videos {
            return VideosResult(data: videos, paging: pagingInfo)
        } else if let media = contentResultsVideo.media {
            return VideosResult(data: media, paging: pagingInfo)
        } else {
            logger.error(HttpClientManagerAPIError.noContent)
            throw HttpClientManagerAPIError.noContent
        }
    }
    
    // MARK: Fetch Video
    /// Fetch ``PSVideo`` from [`URL`](https://developer.apple.com/documentation/foundation/url)
    /// - Parameter url: The URL to fetch from.
    /// - Returns: A result type of ``VideoResult``
    internal func fetchVideo(url: URL) async throws -> VideoResult {
        let contentResultsVideo : ContentResults<PSVideo> = try await apiCall(url: url)
        
        let pagingInfo = PSPagingInfo(
            page: contentResultsVideo.page,
            perPage: contentResultsVideo.perPage,
            totalResults: contentResultsVideo.totalResults,
            previousPage: contentResultsVideo.previousPage,
            nextPage: contentResultsVideo.nextPage
        )
        if let video = contentResultsVideo.videos?.first {
            return VideoResult(data: video, paging: pagingInfo)
        } else if let media = contentResultsVideo.media?.first {
            return VideoResult(data: media, paging: pagingInfo)
        } else {
            logger.error(HttpClientManagerAPIError.noContent)
            throw HttpClientManagerAPIError.noContent
        }
    }
     
    // MARK: Fetch Generic Type
    /// Fetch generic type `<T>` from [`URL`](https://developer.apple.com/documentation/foundation/url)
    /// - Parameter url: The URL to fetch from.
    /// - Returns: Result type for a generic type of `<T>`.
    internal func apiCall<T: Codable>(url: URL) async throws -> T  {
        logger.message("Start fetching from URL: \(url.absoluteString)")
        guard !apiKey.isEmpty else {
            logger.error(HttpClientManagerAPIError.noAPIKey)
            throw HttpClientManagerAPIError.noAPIKey
        }
        var req = URLRequest(url: url)
        req.setValue(apiKey, forHTTPHeaderField: apiHeader)
        do {
            var data: Data
            var response: URLResponse
            if #available(iOS 15.0, *) {
                (data, response) = try await urlSession.data(for: req)
            } else { // async/await compatibility for iOS 13 & macOS 10.15
                (data, response) = try await urlSession.dataWithCheckedThrowingContinuation(for: req)
            }

            guard let response = response as? HTTPURLResponse else {
                logger.error(HttpClientManagerAPIError.noResponse(req.debugDescription))
                throw HttpClientManagerAPIError.noResponse(req.debugDescription)
            }

            logger.response(response)
            saveRateLimits(for: response)

            guard (200...299).contains(response.statusCode) else {
                logger.error(HttpClientManagerAPIError.httpResponse(response.statusCode))
                throw HttpClientManagerAPIError.httpResponse(response.statusCode)
            }

            logger.data(data)

            let result = try JSONDecoder().decode(T.self, from: data)
            return result
        } catch {
            logger.error(HttpClientManagerAPIError.generic(error.localizedDescription))
            throw HttpClientManagerAPIError.generic(error.localizedDescription)
        }
    }
    /// Saves the rate limit data of a given
    /// [`HTTPURLResponse`](https://developer.apple.com/documentation/foundation/httpurlresponse) to
    /// ``PexelsSwift/PexelsSwift/rateLimit-swift.property``, if possible
    /// - Parameter response: The response to fetch the rate limit data from
    private func saveRateLimits(for response: HTTPURLResponse) {
        guard let limit = response.pexelsLimit,
              let remaining = response.pexelsRemaining,
              let reset = response.pexelsReset
        else { return }

        self.rateLimit = .init(
            limit: limit,
            remaining: remaining,
            reset: reset
        )
    }
    //MARK: - QueryParameter
    // swiftlint:disable:next type_name
    private typealias P = QueryParameter
     
    // MARK: Get Photo
    /// Gets a single ``PSPhoto`` based on a given ID
    ///
    /// If the request fails this will return `nil`
    /// - Parameter id: The ID of the Photo
    /// - Returns: A result type of ``PhotoResult``
    public func getPhoto(by id: Int) async throws -> PhotoResult {
        guard !apiKey.isEmpty else {
            throw HttpClientManagerAPIError.noAPIKey
        }
        guard let url = URL(string: API.photoByID(id))
        else {
            throw HttpClientManagerAPIError.badURL(API.photoByID(id))
        }

        return try await fetchPhoto(url: url)
    }
 
    // MARK: Get Curated Photos

    /// Get a list of curated ``PSPhoto``
    /// - Parameters:
    ///   - page: The page/offset to get. Defaults to `1`
    ///   - count: The number of results a page should contain. Defaults to `10`
    /// - Returns: A result type of ``PhotosResult``
    public func getPhotos(
        page: Int = 1,
        count: Int = 10
    ) async throws -> PhotosResult {
        guard var components: URLComponents = .init(string: API.curatedPhotos)
        else {
            throw HttpClientManagerAPIError.badURL(API.curatedPhotos)
        }
        let param: [URLQueryItem] = [.init(name: P.page,
                                           value: page.string),
                                     .init(name: P.perPage,
                                           value: count.string)]

        components.queryItems = param
        guard let url = components.url else {
            throw HttpClientManagerAPIError.badURL(components.debugDescription)
        }
        return try await fetchPhotos(url: url)
    }
 
    // MARK: Search Photos

    /// Get a list of ``PSPhoto`` based on a search query
    /// - Parameters:
    ///   - query: The search query.
    ///   - page: The page/offset to get. Defaults to `1`
    ///   - count: The number of results a page should contain. Defaults to `10`
    ///   - orientation: The orientation. Defaults to `nil`
    ///   - size: The minimum size. Defaults to `nil`
    ///   - color: The color. Defaults to `nil`
    ///   - locale: The Locale. Defaults to `nil`
    /// - Returns: A result type of ``PhotosResult``
    public func searchPhotos(
        _ query: String,
        orientation: PSOrientation? = nil,
        size: PSSize? = nil,
        color: PSColor? = nil,
        locale: PSLocale? = nil,
        page: Int = 1,
        count: Int = 10
    ) async throws -> PhotosResult {
        guard var components: URLComponents = .init(string: API.searchPhotos)
        else {
            throw HttpClientManagerAPIError.badURL(API.searchPhotos)
        }
        var param: [URLQueryItem] = [.init(name: P.query, value: query),
                                          .init(name: P.page, value: page.string),
                                          .init(name: P.perPage, value: count.string)]

        if let orientation = orientation {
            param.append(.init(name: P.orientation, value: orientation.rawValue))
        }
        if let size = size {
            param.append(.init(name: P.size, value: size.rawValue))
        }
        if let color = color {
            param.append(.init(name: P.color, value: color.rawValue))
        }
        if let locale = locale {
            param.append(.init(name: P.locale, value: locale.rawValue))
        }
        components.queryItems = param
        guard let url = components.url else {
            throw HttpClientManagerAPIError.badURL(components.debugDescription)
        }
        return try await fetchPhotos(url: url)
    }

    // MARK: Get Photos for Category ID

    /// Get a list of ``PSPhoto`` based on a gived category ID
    /// - Parameters:
    ///   - categoryID: The category ID
    ///   - page: The page/offset to get. Defaults to `1`
    ///   - count: The number of results a page should contain. Defaults to `10`
    /// - Returns: A result type of ``PhotosResult``
    public func getPhotos(
        for categoryID: CategoryID,
        page: Int = 1,
        count: Int = 10
    ) async throws -> PhotosResult {
        guard var components: URLComponents = .init(string: API.collections(categoryID))
        else {
            throw HttpClientManagerAPIError.badURL(API.collections(categoryID))
        }
        let param: [URLQueryItem] = [.init(name: P.type, value: "photos"),
                                          .init(name: P.page, value: page.string),
                                          .init(name: P.perPage, value: count.string)]

        components.queryItems = param
        guard let url = components.url else {
            throw HttpClientManagerAPIError.badURL(components.debugDescription)
        }
        return try await fetchPhotos(url: url)
    } 
     
    // MARK: Get Video

    /// Gets a single ``PSVideo`` based on a given ID
    ///
    /// If the request fails this will return `nil`
    /// - Parameter id: The ID of the Video
    /// - Returns: A result type of ``VideoResult``
    public func getVideo(by id: Int) async throws -> VideoResult {
        guard !apiKey.isEmpty else {
            throw HttpClientManagerAPIError.noAPIKey
        }
        guard let url = URL(string: API.videoByID(id))
        else {
            throw HttpClientManagerAPIError.badURL(API.videoByID(id))
        }
        return try await fetchVideo(url: url)
    } 
     
    // MARK: Get Popular Videos

    /// Get a list of popular videos
    /// - Parameters:
    ///   - minimumWidth: The minimum width in pixels of the returned videos.
    ///   - minimumHeight: The minimum height in pixels of the returned videos.
    ///   - minimumDuration: The minimum duration in seconds of the returned videos.
    ///   - maximumDuration: The maximum duration in seconds of the returned videos.
    ///   - page: The page/offset to get. Defaults to `1`
    ///   - count: The number of results a page should contain. Defaults to `10`
    /// - Returns: A result type of ``VideosResult``
    public func getPopularVideos(
        minimumWidth: Int? = nil,
        minimumHeight: Int? = nil,
        minimumDuration: Int? = nil,
        maximumDuration: Int? = nil,
        page: Int = 1,
        count: Int = 10
    ) async throws -> VideosResult {
        guard var components: URLComponents = .init(string: API.popularVideos)
        else {
            throw HttpClientManagerAPIError.badURL(API.popularVideos)
        }
        var param: [URLQueryItem] = [.init(name: P.page, value: page.string),
                                          .init(name: P.perPage, value: count.string)]
        if let minimumWidth = minimumWidth {
            param.append(.init(name: P.minWidth, value: minimumWidth.string))
        }
        if let minimumHeight = minimumHeight {
            param.append(.init(name: P.minHeight, value: minimumHeight.string))
        }
        if let minimumDuration = minimumDuration {
            param.append(.init(name: P.minDuration, value: minimumDuration.string))
        }
        if let maximumDuration = maximumDuration {
            param.append(.init(name: P.maxDuration, value: maximumDuration.string))
        }

        components.queryItems = param
        guard let url = components.url else {
            throw HttpClientManagerAPIError.badURL(components.debugDescription)
        }
        return try await fetchVideos(url: url)
    }
 
    // MARK: Search Videos

    /// Get a list of ``PSVideo`` based on a search query
    /// - Parameters:
    ///   - query: The search query.
    ///   - orientation: Desired video orientation. Defaults to `nil`
    ///   - size: Minimum video size. Defaults to `nil`
    ///   - locale: The Locale. Defaults to `nil`
    ///   - page: The page/offset to get. Defaults to `1`
    ///   - count: The number of results a page should contain. Defaults to `10`
    /// - Returns: A result type of ``VideosResult``
    public func searchVideos(
        _ query: String,
        orientation: PSOrientation? = nil,
        size: PSSize? = nil,
        locale: PSLocale? = nil,
        page: Int = 1,
        count: Int = 10
    ) async throws -> VideosResult {
        guard var components: URLComponents = .init(string: API.searchVideos)
        else {
            throw HttpClientManagerAPIError.badURL(API.searchVideos)
        }
        var param: [URLQueryItem] = [.init(name: P.query, value: query),
                                          .init(name: P.page, value: page.string),
                                          .init(name: P.perPage, value: count.string)]
        if let orientation = orientation {
            param.append(.init(name: P.orientation, value: orientation.rawValue))
        }
        if let size = size {
            param.append(.init(name: P.size, value: size.rawValue))
        }
        if let locale = locale {
            param.append(.init(name: P.locale, value: locale.rawValue))
        }

        components.queryItems = param
        guard let url = components.url else {
            throw HttpClientManagerAPIError.badURL(components.debugDescription)
        }
        return try await fetchVideos(url: url)
    }

    // MARK: Get Videos for Category ID
    /// Get a list of ``PSVideo`` based on a gived category ID
    /// - Parameters:
    ///   - categoryID: The category ID
    ///   - page: The page/offset to get. Defaults to `1`
    ///   - count: The number of results a page should contain. Defaults to `10`
    /// - Returns: A result type of ``VideosResult``
    public func getVideos(
        for categoryID: CategoryID,
        page: Int = 1,
        count: Int = 10
    ) async throws -> VideosResult {
        guard var components: URLComponents = .init(string: API.collections(categoryID))
        else {
            throw HttpClientManagerAPIError.badURL(API.collections(categoryID))
        }
        let param: [URLQueryItem] = [.init(name: P.type, value: "videos"),
                                          .init(name: P.page, value: page.string),
                                          .init(name: P.perPage, value: count.string)]

        components.queryItems = param
        guard let url = components.url else {
            throw HttpClientManagerAPIError.badURL(components.debugDescription)
        }
        return try await fetchVideos(url: url)
    }
   
    // MARK: Get Collections

    /// Get a list of ``PSCollection``
    /// - Parameters:
    ///   - page: The page/offset to get. Defaults to `1`
    ///   - count: The number of results a page should contain. Defaults to `10`
    /// - Returns: A result type of ``CollectionResult``
    public func getCollections(
        page: Int = 1,
        count: Int = 10
    ) async throws -> CollectionResult {
        guard var components: URLComponents = .init(string: API.featuredCollections)
        else {
            throw HttpClientManagerAPIError.badURL(API.featuredCollections)
        }
        let param: [URLQueryItem] = [.init(name: P.page,
                                           value: page.string),
                                     .init(name: P.perPage,
                                           value: count.string)]

        components.queryItems = param
        guard let url = components.url else {
            throw HttpClientManagerAPIError.badURL(components.debugDescription)
        }
        guard !apiKey.isEmpty else { throw HttpClientManagerAPIError.noAPIKey }

        let collectionResults: CollectionResults = try await apiCall(url: url)
        let paging = PSPagingInfo(
            page: collectionResults.page,
            perPage: collectionResults.perPage,
            totalResults: collectionResults.totalResults,
            previousPage: collectionResults.previousPage,
            nextPage: collectionResults.nextPage
        )
        return CollectionResult(data: collectionResults.collections, paging: paging)
    }

    //MARK: -end of http manager
}

//MARK: -- extensions
@available(iOS, deprecated: 15, message: "Use the built-in API instead")
extension URLSession {
    /// Downloads the contents of a URL based on the specified URL request and delivers the data asynchronously.
    ///
    /// This is a legacy implementation for `URLSession.data(for:)` prior to iOS 15.
    /// - Parameter request: A URL request object that provides request-specific information such as
    /// the URL, cache policy, request type, and body data or body stream.
    /// - Returns: An asynchronously-delivered tuple that contains the URL contents as
    /// a `Data` instance, and a `URLResponse`.
    func dataWithCheckedThrowingContinuation(for request: URLRequest) async throws -> (Data, URLResponse) {
        return try await withCheckedThrowingContinuation { continuation in
            let task = self.dataTask(with: request) { data, response, error in
                guard let data = data, let response = response else {
                    let error = error ?? URLError(.badServerResponse)
                    return continuation.resume(throwing: error)
                }
                continuation.resume(returning: (data, response))
            }
            task.resume()
        }
    }
}

internal extension Data {
    func prettyJSON() -> String? {
        if let json = try? JSONSerialization.jsonObject(with: self, options: .mutableContainers),
           let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
            return String(decoding: jsonData, as: UTF8.self)
        }
        return nil
    }
}

public extension HTTPURLResponse {
    /// Returns an integer describing the Pexels API call limit, if set.
    ///
    /// - Note: This will only be set if a API call was made previously.
    var pexelsLimit: Int? {
        Int(self.value(forHTTPHeaderField: RateLimitType.limit.rawValue) ?? "")
    }

    /// Returns an integer describing the Pexels API remaining calls, if set.
    ///
    /// - Note: This will only be set if a API call was made previously.
    var pexelsRemaining: Int? {
        Int(self.value(forHTTPHeaderField: RateLimitType.remaining.rawValue) ?? "")
    }

    /// Returns a date describing the reset date for the `pexelsLimit`, if set.
    ///
    /// - Note: This will only be set if a API call was made previously.
    var pexelsReset: Date? {
        guard let interval = Double(self.value(forHTTPHeaderField: RateLimitType.reset.rawValue) ?? "")
        else { return nil }
        return Date(timeIntervalSince1970: interval)
    }
}

internal extension Int {
    var string: String {
        "\(self)"
    }
}
//MARK: - Content Results Model
/// Content Results Wrapper with generic type `<T>`
public struct ContentResults<T: Codable>: Codable {
    enum CodingKeys: String, CodingKey {
        case photos, media, videos, page
        case perPage = "per_page"
        case totalResults = "total_results"
        case previousPage = "prev_page"
        case nextPage = "next_page"
    }
    var photos: [PSPhoto]? // When searching, or featured
    var media: [T]? // When fetching from collections
    var videos: [PSVideo]? // When fetching videos
    var page: Int
    var perPage: Int
    var totalResults: Int
    var previousPage: String?
    var nextPage: String?
}

//MARK: - Collection Results Model
/// Collection Results Wrapper
public struct CollectionResults: Codable {
    enum CodingKeys: String, CodingKey {
        case collections, page
        case perPage = "per_page"
        case totalResults = "total_results"
        case previousPage = "prev_page"
        case nextPage = "next_page"
    }

    var collections: [PSCollection]
    var page: Int
    var perPage: Int
    var totalResults: Int
    var previousPage: String?
    var nextPage: String?
}
//MARK: - Video Model
/// A structure representing a Video and its metadata.
public struct PSVideo: Identifiable, Codable, Equatable {

    enum CodingKeys: String, CodingKey {
        case id, width, height, url, image, duration, user
        case videoFiles = "video_files"
        case videoPictures = "video_pictures"
    }

    /// The ID of the video.
    public var id: Int

    /// The real width of the video in pixels.
    public var width: Int

    /// The real height of the video in pixels.
    public var height: Int

    /// The Pexels URL where the video is located.
    public var url: String

    /// URL to a screenshot of the video.
    public var image: String

    /// The duration of the video in seconds.
    public var duration: Int

    /// The videographer who shot the video.
    public var user: Videographer

    /// An array of different sized versions of the video.
    public var videoFiles: [File]

    /// An array of preview pictures of the video.
    public var videoPictures: [Preview]

    /// A structure representing a videographer
    public struct Videographer: Identifiable, Codable, Equatable {

        /// The ID of the videographer.
        public var id: Int

        /// The name of the videographer.
        public var name: String

        /// The URL of the videographer's Pexels profile.
        public var url: String
    }

    /// A structure representing a video file and its metadata.
    public struct File: Identifiable, Codable, Equatable {
        enum CodingKeys: String, CodingKey {
            case id, width, height, link, quality
            case fileType = "file_type"
        }

        /// The ID of the ``PSVideo/File``.
        public var id: Int

        /// The quality of the ``PSVideo/File``.
        public var quality: Quality

        /// The video format.
        public var fileType: String

        /// The width in pixels.
        public var width: Int?

        /// The height in pixels
        public var height: Int?

        /// The frames per second of the ``PSVideo/File``.
        public var fps: Double?

        /// A link to where the ``PSVideo/File`` is hosted.
        public var link: String

        /// A collection of possible video qualities `[hd, sd, hls]`.
        public enum Quality: String, Codable {
            case hd, sd, hls
        }
    }

    /// A structure representing a preview picture of a video.
    public struct Preview: Identifiable, Codable, Equatable {
        enum CodingKeys: String, CodingKey {
            case id
            case link = "picture"
            case index = "nr"
        }

        /// The ID of the ``PSVideo/Preview``.
        public var id: Int

        /// A link to the preview image.
        public var link: String

        /// The index in the array.
        public var index: Int
    }
}
//MARK: - Photo Model
/// A structure representing a Photo and its metadata.
public struct PSPhoto: Identifiable, Codable, Equatable {

    enum CodingKeys: String, CodingKey {
        case id, url, width, height, photographer
        case alternateDescription = "alt"
        case source = "src"
        case photographerURL = "photographer_url"
        case photographerID = "photographer_id"
        case averageColor = "avg_color"
    }

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

//MARK: - Collection Model
/// A structure representing a Collection and its metadata.
public struct PSCollection: Identifiable, Codable, Equatable {

    enum CodingKeys: String, CodingKey {
        case id, title, description
        case isPrivate = "private"
        case mediaCount = "media_count"
        case photosCount = "photos_count"
        case videosCount = "videos_count"
    }

    /// The ID of the collection.
    public var id: String

    /// The name of the collection.
    public var title: String

    /// The description of the collection.
    public var description: String

    /// A flag indicating whether or not the collection is marked as private.
    public var isPrivate: Bool

    /// The total number of media included in this collection.
    public var mediaCount: Int

    /// The total number of photos included in this collection.
    public var photosCount: Int

    /// The total number of videos included in this collection.
    public var videosCount: Int

}
//MARK: - Paging Model
/// Metadata useful for paging (page, total results, next page, ...)
public struct PSPagingInfo: Codable {
    enum CodingKeys: String, CodingKey {
        case page
        case perPage = "per_page"
        case totalResults = "total_results"
        case previousPage = "prev_page"
        case nextPage = "next_page"
    }
    /// The current page
    public var page: Int

    /// The number of results on this page
    public var perPage: Int

    /// The total number of results
    public var totalResults: Int

    /// The URL-Path of the previous page if available.
    public var previousPage: String?

    /// The URL-Path of the next page if available.
    public var nextPage: String?
}

//MARK: Logger
/// A collection of log levels.
public enum PSLogLevel {
    /// Nothing will be logged.
    case off
    /// Only errors will be logged.
    case error
    /// Only errors and responses will be logged
    case info
    /// Errors, responses, and data will be logged
    case debug
}

/// The delegate for receiving log messages.
///
/// This is useful if you use a logging service like Sentry and need to inject the messages.
public protocol PSLoggerDelegate: AnyObject {
    /// This is called whenever a log happens in the scope of the ``PSLogLevel``
    func psLoggerMessageReceived(_ message: String)
}

/// A logger for displaying logs in the console.
///
/// Setup the logger through ``PexelsSwift/PexelsSwift``'s ``PexelsSwift/PexelsSwift/setup(apiKey:logLevel:)`` method.
///
/// - Note: Remember to set the ``PSLogLevel`` to ``PSLogLevel/off`` once
/// moving to `production`!
public class PSLogger {

    private typealias RateLimit = RateLimitType

    /// Returns the current ``PSLogLevel``.
    public private(set) var logLevel: PSLogLevel

    /// The delegate for receiving log messages.
    ///
    /// This is useful if you use a logging service like Sentry and need to inject the messages.
    public weak var delegate: PSLoggerDelegate?

    internal init() {
        self.logLevel = .info
    }

    /// Set the ``logLevel`` of the logger.
    /// - Parameter logLevel: The log level
    func setLogLevel(_ logLevel: PSLogLevel) {
        self.logLevel = logLevel
    }

    /// Logs a message to the console
    ///
    /// - Note: Only logs to the console if the ``logLevel`` is
    /// **not** set to ``PSLogLevel/off``
    /// - Parameter message: The message to log.
    func message(_ message: String) {
        guard logLevel != .off else { return }
        var logMessage = logTitle(for: .info)
        logMessage.append(message)
        print(logMessage)
        delegate?.psLoggerMessageReceived(logMessage)
    }

    /// Logs a ``PSError`` to the console
    ///
    /// - Note: Only logs to the console if the ``logLevel`` is
    /// set to ``PSLogLevel/error``, ``PSLogLevel/info``, or ``PSLogLevel/debug``.
    /// - Parameter error: The error to log.
    func error(_ error: HttpClientManager.HttpClientManagerAPIError) {
        guard logLevel != .off else { return }
        var logMessage = logTitle(for: .error)
        logMessage.append("Error: \(error.description)")
        print(logMessage)
        delegate?.psLoggerMessageReceived(logMessage)
    }

    /// Logs a [HTTPURLResponse](https://developer.apple.com/documentation/foundation/httpurlresponse) to the console
    ///
    /// - Note: Only logs to the console if the ``logLevel`` is
    /// ``PSLogLevel/info`` or ``PSLogLevel/debug``.
    /// - Parameter response: The response to log.
    func response(_ response: HTTPURLResponse) {
        guard logLevel == .info || logLevel == .debug else { return }
        var logMessage = logTitle(for: .info)
        logMessage.append("Code: \(response.statusCode),")
        logMessage.append("URL: \(response.url?.absoluteString ?? "Invalid URL"),")
        if (200...299).contains(response.statusCode) {
            logMessage.append("Rate Limit: \(response.pexelsLimit?.string ?? "Fetching failed"),")
            logMessage.append("Remaining: \(response.pexelsRemaining?.string ?? "Fetching failed"),")
            logMessage.append("Reset on: \(response.pexelsReset?.description ?? "Fetching Failed")")
        } else {
            logMessage.append("Response: \(response.description)")
        }
        print(logMessage)
        delegate?.psLoggerMessageReceived(logMessage)
    }

    /// Logs data to the console in a prettified JSON string
    /// - Note: Only logs to the console if the ``logLevel`` is
    /// ``PSLogLevel/debug``
    /// - Parameter data: The data to log.
    func data(_ data: Data) {
        guard logLevel == .debug else { return }
        if let json = data.prettyJSON() {
            var logMessage = logTitle(for: .success)
            logMessage.append("Data: \(json)")
            print(logMessage)
            delegate?.psLoggerMessageReceived(logMessage)
        } else {
            var logMessage = logTitle(for: .warning)
            logMessage.append("Invalid JSON Data")
            print(logMessage)
            delegate?.psLoggerMessageReceived(logMessage)
        }
    }
}

public extension PSLogger {
    private func logTitle(for logType: PSLogType) -> String {
        "\(icon(for: logType)) Pexels-Swift: "
    }

    private enum PSLogType {
        case info, success, warning, error
    }

    private func icon(for logType: PSLogType) -> String {
        switch logType {
        case .info:
            return "💬"
        case .success:
            return "✅"
        case .warning:
            return "⚠️"
        case .error:
            return "🛑"
        }
    }
}
//MARK: enums
//MARK: -- search queries
/// Colors for ``PSPhoto`` search queries
public enum PSColor: String {
    case red, orange, yellow, green, turquoise, blue, violet, pink, brown, black, gray, white
}

/// Supported orientations for search queries.
public enum PSOrientation: String {
    case landscape, portrait, square
}

/// Supported sizes for search queries.
public enum PSSize: String {
    case large, medium, small
}

/// Supported locales for search queries
public enum PSLocale: String {
    case en_US = "'en-US'"
    case pt_BR = "'pt-BR'"
    case es_ES = "'es-ES'"
    case ca_ES = "'ca-ES'"
    case de_DE = "'de-DE'"
    case it_IT = "'it-IT'"
    case fr_FR = "'fr-FR'"
    case sv_SE = "'sv-SE'"
    case id_ID = "'id-ID'"
    case pl_PL = "'pl-PL'"
    case ja_JP = "'ja-JP'"
    case zh_TW = "'zh-TW'"
    case zh_CN = "'zh-CN'"
    case ko_KR = "'ko-KR'"
    case th_TH = "'th-TH'"
    case nl_NL = "'nl-NL'"
    case hu_HU = "'hu-HU'"
    case vi_VN = "'vi-VN'"
    case cs_CZ = "'cs-CZ'"
    case da_DK = "'da-DK'"
    case fi_FI = "'fi-FI'"
    case uk_UA = "'uk-UA'"
    case ro_RO = "'ro-RO'"
    case nb_NO = "'nb-NO'"
    case sk_SK = "'sk-SK'"
    case tr_TR = "'tr-TR'"
    case ru_RU = "'ru-RU'"
}

/// A collection of query parameters
public enum QueryParameter {
    public static var query = "query"
    public static var page = "page"
    public static var perPage = "per_page"
    public static var orientation = "orientation"
    public static var size = "size"
    public static var color = "color"
    public static var locale = "locale"
    public static var type = "type"
    public static var minWidth = "min_width"
    public static var minHeight = "min_height"
    public static var minDuration = "min_duration"
    public static var maxDuration = "max_duration"
}

/// Keys for getting Rate Limit statistics from response headers.
///
/// Use the `value(for:type:)` function to get the corresponding
/// string value in the
/// [HTTPURLResponse](https://developer.apple.com/documentation/foundation/httpurlresponse) object.
public enum RateLimitType: String {
    case limit = "X-Ratelimit-Limit"
    case remaining = "X-Ratelimit-Remaining"
    case reset = "X-Ratelimit-Reset"
}

/// Struct that holds the most recent values for Rate Limit staticstics
public struct RateLimit {

    /// The monthly limit of API calls.
    public var limit: Int?

    /// The remaining calls within the ``limit``.
    public var remaining: Int?

    /// The reset date when ``remaining`` gets reset to ``limit``.
    public var reset: Date?
}
//MARK: - models

/// Result type for an array of ``PSVideo``.
public struct VideosResult  {
    public let data: [PSVideo]
    public let paging: PSPagingInfo
}
 
/// Result type for a single ``PSVideo``.
public struct VideoResult  {
    public let data: PSVideo
    public let paging: PSPagingInfo
}

/// Result type for an array of ``PSPhoto``.
public struct PhotosResult  {
    public let data: [PSPhoto]
    public let paging: PSPagingInfo
}

/// Result type for a single ``PSPhoto``.
public struct PhotoResult {
    public let data: PSPhoto
    public let paging: PSPagingInfo
}
 
/// Result type for an array of ``PSCollection``.
public struct CollectionResult {
    public let data: [PSCollection]
    public let paging: PSPagingInfo
}
