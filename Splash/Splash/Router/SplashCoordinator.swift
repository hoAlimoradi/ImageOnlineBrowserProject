//
//  SplashCoordinator.swift
//  Splash
//
//  Created by hoseinAlimoradi on 6/23/23.
//

import UIKit
import Commons

protocol SplashRouting {
    func navigateToMainTab()
}

public protocol SplashCoordinatorDelegate: AnyObject {
    func navigateToMainTab()
}

public final class SplashCoordinator: Coordinator,
                                      SplashRouting {
    // MARK: - Variables
    public var viewController: UIViewController?
    public var navigationController: UINavigationController?
    public weak var coordinatorDelegate:SplashCoordinatorDelegate?

    // MARK: - Life Cycle
    public init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    public func start() {
        let splashViewController = makeSplashViewController()
        self.navigationController?.setViewControllers([splashViewController], animated: true)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func makeSplashViewController() -> SplashViewController {
        let splashAPI = SplashAPI()
        let config = SplashModule.Configuration(splashAPI: splashAPI)
        let splashViewController = SplashModule.build(with: config,
                                                      router: self)
        return splashViewController
    }
     
    func navigateToMainTab() {
        coordinatorDelegate?.navigateToMainTab()
    } 
}
 
