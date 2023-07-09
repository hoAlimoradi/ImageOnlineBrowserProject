//
//  DetailsModule.swift
//  Detials
//
//  Created by hoseinAlimoradi on 7/9/23.
//
import UIKit

enum DetailsModule {

    struct Configuration {
        let detailsAPI: DetailsAPIProtocol
        let collectionCategoryId: String
        let collectionTitle: String
    }

    // MARK: - Alias
    typealias SceneView = DetailsViewController

    static func build(with configuration: Configuration,
                      router: DetailsCoordinator) -> SceneView {
        let viewModel = DetailsViewModel(configuration: configuration)
        let router = router
        let viewController = SceneView(configuration: configuration,
                                       viewModel: viewModel,
                                       router: router)
        router.viewController = viewController
        return viewController
    }
}

