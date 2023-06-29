//
//  SplashModule.swift
//  Splash
//
//  Created by hoseinAlimoradi on 6/23/23.
//
import UIKit

enum SplashModule {

    struct Configuration {
        let splashAPI: SplashAPIProtocol 
    }

    // MARK: - Alias
    typealias SceneView = SplashViewController

    static func build(with configuration: Configuration,
                      router: SplashCoordinator) -> SceneView {
        let viewModel = SplashViewModel(configuration: configuration)
        let router = router 
        let viewController = SceneView(configuration: configuration,
                                       viewModel: viewModel,
                                       router: router)
        router.viewController = viewController
        return viewController
    }
}
