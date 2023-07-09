//
//  HomeRouting.swift
//  Home
//
//  Created by hoseinAlimoradi on 7/8/23.
//

import UIKit
import Commons

protocol HomeRouting {
    func navigateToDetails(collectionCategoryId: String,
                           collectionTitle: String)
}

public protocol HomeCoordinatorDelegate: AnyObject {
    func navigateToDetails(collectionCategoryId: String,
                           collectionTitle: String)
}

public final class HomeCoordinator: Coordinator,
                                      HomeRouting {
    // MARK: - Variables
    public var viewController: UIViewController?
    public var navigationController: UINavigationController?
    public weak var coordinatorDelegate: HomeCoordinatorDelegate?

    // MARK: - Life Cycle
    public init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    public func start() {
        let homeViewController = makeHomeViewController()
        self.navigationController?.setViewControllers([homeViewController], animated: true)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func makeHomeViewController() -> HomeViewController {
        let homeAPI = HomeAPI()
        let config = HomeModule.Configuration(homeAPI: homeAPI)
        let homeViewController = HomeModule.build(with: config,
                                                  router: self)
        return homeViewController
    }
     
    func navigateToDetails(collectionCategoryId: String,
                           collectionTitle: String) {
        coordinatorDelegate?.navigateToDetails(collectionCategoryId: collectionCategoryId,
                                               collectionTitle: collectionTitle)
    }
}
 


