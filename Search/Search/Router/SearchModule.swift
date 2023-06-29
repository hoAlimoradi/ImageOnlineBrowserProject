//
//  SearchModule.swift
//  Search
//
//  Created by hoseinAlimoradi on 6/27/23.
//
import UIKit

enum SearchModule {

    struct Configuration {
        let searchAPI: SearchAPIProtocol
    }

    // MARK: - Alias
    typealias SceneView = SearchViewController

    static func build(with configuration: Configuration,
                      router: SearchCoordinator) -> SceneView {
        let viewModel = SearchViewModel(configuration: configuration)
        let router = router
        let viewController = SceneView(configuration: configuration,
                                       viewModel: viewModel,
                                       router: router)
        router.viewController = viewController
        return viewController
    }
}
