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

public class MainCoordinator: Coordinator {
    
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
extension MainCoordinator: SearchCoordinatorDelegate {
    public func navigateToDetails(id: String) {
        
    }
}

// MARK: - Home Extensions
extension MainCoordinator: HomeCoordinatorDelegate {
    public func navigateToMainTab() {
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
