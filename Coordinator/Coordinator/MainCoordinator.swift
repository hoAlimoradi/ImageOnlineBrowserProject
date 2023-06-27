//
//  MainCoordinator.swift
//  Coordinator
//
//  Created by hoseinAlimoradi on 6/23/23.
//

import UIKit
import Splash
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
    
//
//    public func wantsToNavigateToHomeCoordinator() {
//        let homeCoordinator = HomePageCoordinator(navigationController: navigationController)
//        homeCoordinator.coordinatorDelegate = self
//        homeCoordinator.start()
//    }
    
}

// MARK: - HomeCoordinatorDelegate Extensions
extension MainCoordinator: SplashCoordinatorDelegate {
    public func navigateToMainTab() {
         
    }
    /*
     public func loginCoordinatorDelegate() {
         let firstFeatureCoordinator = LoginCoordinator(navigationController: navigationController)
         firstFeatureCoordinator.coordinatorDelegate = self
         firstFeatureCoordinator.start() 
     }

     public func homeCoordinatorDelegate() {
         let secondFeatureCoordinator = HomeCoordinator(navigationController: navigationController)
         secondFeatureCoordinator.coordinatorDelegate = self
         secondFeatureCoordinator.start()
     }
     */
}
