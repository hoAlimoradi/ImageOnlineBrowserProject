//
//  SearchAPI.swift
//  Search
//
//  Created by hoseinAlimoradi on 6/27/23.
//

import Foundation
import Combine

protocol SearchAPIProtocol {
    func search(title: String) async throws -> [ImageModel]
}

class SearchAPI: SearchAPIProtocol {

    enum TasksAPIError: Error {
        case invalidResponse
        case invalidSelf
    }
    
    private var cancelables = Set<AnyCancellable>()

    func search(title: String) async throws -> [ImageModel] {
        let mock1 = ImageModel(id: UUID().uuidString ,
                                       name: "test 1",
                                       description: "kjsdlkfjlk",
                                       like: false)
        let mock2 = ImageModel(id: UUID().uuidString ,
                                       name: "test 2",
                                       description: "saaalsdsdkfjlk",
                                       like: false)
        return [mock1, mock2]
    }
}


struct ImageModel {
    var id: String
    var name: String
    var description: String?
    var like: Bool
}
