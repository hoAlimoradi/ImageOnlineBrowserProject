//
//  HomeModule.swift
//  Home
//
//  Created by hoseinAlimoradi on 7/8/23.
//

import UIKit

enum HomeModule {

    struct Configuration {
        let homeAPI: HomeAPIProtocol
    }

    // MARK: - Alias
    typealias SceneView = HomeViewController

    static func build(with configuration: Configuration,
                      router: HomeCoordinator) -> SceneView {
        let viewModel = HomeViewModel(configuration: configuration)
        let router = router
        let viewController = SceneView(configuration: configuration,
                                       viewModel: viewModel,
                                       router: router)
        router.viewController = viewController
        return viewController
    }
}

