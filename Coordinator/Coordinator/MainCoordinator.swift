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
    public func navigateToMainTab() {
        let searchCoordinator = SearchCoordinator(navigationController: self.navigationController)
        searchCoordinator.coordinatorDelegate = self
        searchCoordinator.start()
    }
}

// MARK: - Search Extensions
extension MainCoordinator: SearchCoordinatorDelegate {
    public func navigateToDetails(id: String) {
        
    }
}

