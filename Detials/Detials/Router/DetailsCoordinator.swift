//
//  DetailsRouting.swift
//  Detials
//
//  Created by hoseinAlimoradi on 7/9/23.
//

import UIKit
import Commons

protocol DetailsRouting {
    func popUpFromDetails()
}

public protocol DetailsCoordinatorDelegate: AnyObject {
    func popUpFromDetails()
}

public final class DetailsCoordinator: Coordinator,
                                      DetailsRouting {
    // MARK: - Variables
    public var viewController: UIViewController?
    public var navigationController: UINavigationController?
    public weak var coordinatorDelegate: DetailsCoordinatorDelegate?

    // MARK: - Life Cycle
    public init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    public func start(collectionCategoryId: String,
                      collectionTitle: String) {
        let detailsViewController = makeDetailsViewController(collectionCategoryId: collectionCategoryId,
                                                              collectionTitle: collectionTitle)
        self.navigationController?.setViewControllers([detailsViewController], animated: true)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func makeDetailsViewController(collectionCategoryId: String,
                                           collectionTitle: String) -> DetailsViewController {
        let detailsAPI = DetailsAPI()
        let config = DetailsModule.Configuration(detailsAPI: detailsAPI,
                                                 collectionCategoryId: collectionCategoryId,
                                                 collectionTitle: collectionTitle)
        
        let detailsViewController = DetailsModule.build(with: config,
                                                        router: self)
        return detailsViewController
    }
     
    func popUpFromDetails() {
        coordinatorDelegate?.popUpFromDetails()
    }
}
 



