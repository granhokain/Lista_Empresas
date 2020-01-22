//
//  AppCoordinator.swift
//  Lista_Empresas
//
//  Created by Rafael Martins on 21/01/20.
//  Copyright © 2020 Rafael Martins. All rights reserved.
//

import Swinject

class AppCoordinator: Coordinator {
    weak var coordinatorDelegate: CoordinatorDelegate?
    var childCoordinators: [Coordinator] = []
    var navigationController: BaseNavigationController
    var container: Container
    
    init(navigationController: BaseNavigationController,delegate: CoordinatorDelegate?,container: Container
    ) {
        self.navigationController = navigationController
        self.coordinatorDelegate = delegate
        self.container = container
    }
    
    func start() {
        self.showSplash()
    }
    
    func showSplash() {
        let splashCoordinator = SplashCoordinator(navigationController: self.navigationController, container: container, delegate: self)
        splashCoordinator.start()
        self.childCoordinators.append(splashCoordinator)
    }
    
    func showAuthentication() {
        let authCoordinator = AuthCoordinator(navigationController: self.navigationController, container: container, delegate: self)
        authCoordinator.start()
        self.childCoordinators.append(authCoordinator)
    }
    
    func showHome() {
        let homeCoordinator = HomeCoordinator(navigationController: self.navigationController, container: container, delegate: self)
        homeCoordinator.start()
        self.childCoordinators.append(homeCoordinator)
    }
    
    func logout() {
        self.coordinatorDelegate?.coordinatorDidExit(self)
        self.showAuthentication()
    }
}

// MARK: - SplashCoordinatorDelegate
extension AppCoordinator: SplashCoordinatorDelegate {
    func showLogin(_ coordinator: SplashCoordinator) {
        self.showAuthentication()
    }
    
    func showHome(_ coordinator: SplashCoordinator) {
        self.showHome()
    }
}

// MARK: - AuthCoordinatorDelegate
extension AppCoordinator: AuthCoordinatorDelegate {
    func showHome(_ coordinator: AuthCoordinator) {
        self.showHome()
    }
}

// MARK: - HomeCoordinatorDelegate
extension AppCoordinator: HomeCoordinatorDelegate {

    func didLogout(on coordinator: HomeCoordinator) {
        logout()
    }
}
