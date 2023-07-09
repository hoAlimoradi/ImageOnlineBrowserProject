//
//  MainCoordinator.swift
//  Coordinator
//
//  Created by hoseinAlimoradi on 6/23/23.
//

import UIKit
import Splash
import Search
import Commons
import Home
import Detials

public class MainCoordinator: Coordinator, DetailsCoordinatorDelegate {
    public func popUpFromDetails() {
         
    }
    
    
    // MARK: - Variables
    public var childCoordinators = [Coordinator]()
    public var navigationController: UINavigationController?

    // MARK: - Constants
    public required init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
        start()
    }

    // MARK: - Methods
    public func start() {
        navigateToSplashCoordinator()
    }
    
    public func navigateToSplashCoordinator() { 
        let splashCoordinator = SplashCoordinator(navigationController: self.navigationController)
        splashCoordinator.coordinatorDelegate = self
        splashCoordinator.start()
    }
}

// MARK: - Splash Extensions
extension MainCoordinator: SplashCoordinatorDelegate {
    public func navigateToMainTab1() {
        let searchCoordinator = HomeCoordinator(navigationController: self.navigationController)
        searchCoordinator.coordinatorDelegate = self
        searchCoordinator.start()
    }
    /*
     public func navigateToMainTab() {
         let searchCoordinator = SearchCoordinator(navigationController: self.navigationController)
         searchCoordinator.coordinatorDelegate = self
         searchCoordinator.start()
     }
     */
}

// MARK: - Search Extensions

// MARK: - Home Extensions
extension MainCoordinator: HomeCoordinatorDelegate {
    public func navigateToMainTab() {
        let searchCoordinator = HomeCoordinator(navigationController: self.navigationController)
        searchCoordinator.coordinatorDelegate = self
        searchCoordinator.start()
    }
    
    public func navigateToDetails(collectionCategoryId: String,
                                  collectionTitle: String) {
        let detailsCoordinator = DetailsCoordinator(navigationController: self.navigationController)
        detailsCoordinator.coordinatorDelegate = self
        detailsCoordinator.start(collectionCategoryId: collectionCategoryId,
                                 collectionTitle: collectionTitle)
    }
    /*
     public func navigateToMainTab() {
         let searchCoordinator = SearchCoordinator(navigationController: self.navigationController)
         searchCoordinator.coordinatorDelegate = self
         searchCoordinator.start()
     }
     */
}
 

