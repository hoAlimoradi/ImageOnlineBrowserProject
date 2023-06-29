//
//  SearchRouting.swift
//  Search
//
//  Created by hoseinAlimoradi on 6/27/23.
//
import UIKit
import Commons

protocol SearchRouting {
    func navigateToDetails(id: String)
}

public protocol SearchCoordinatorDelegate: AnyObject {
    func navigateToDetails(id: String)
}

public final class SearchCoordinator: Coordinator,
                                      SearchRouting {
    // MARK: - Variables
    public var viewController: UIViewController?
    public var navigationController: UINavigationController?
    public weak var coordinatorDelegate: SearchCoordinatorDelegate?

    // MARK: - Life Cycle
    public init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    public func start() {
        let searchViewController = makeSearchViewController()
        self.navigationController?.setViewControllers([searchViewController], animated: true)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func makeSearchViewController() -> SearchViewController {
        let searchAPI = SearchAPI()
        let config = SearchModule.Configuration(searchAPI: searchAPI)
        let searchViewController = SearchModule.build(with: config,
                                                      router: self)
        return searchViewController
    }
     
    func navigateToDetails(id: String) {
        coordinatorDelegate?.navigateToDetails(id: id)
    }
}
 

