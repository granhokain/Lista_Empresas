//
//  SplashCoordinator.swift
//  Lista_Empresas
//
//  Created by Rafael Martins on 22/01/20.
//  Copyright © 2020 Rafael Martins. All rights reserved.
//

import Foundation
import Swinject

protocol SplashCoordinatorDelegate: CoordinatorDelegate {
    func showHome(_ coordinator: SplashCoordinator)
    func showLogin(_ coordinator: SplashCoordinator)
}

class SplashCoordinator: Coordinator {
    var container: Container
    weak var delegate: SplashCoordinatorDelegate?
    weak var coordinatorDelegate: CoordinatorDelegate?
    var childCoordinators: [Coordinator] = []
    var navigationController: BaseNavigationController
    
    init(navigationController: BaseNavigationController, container: Container, delegate: SplashCoordinatorDelegate) {
        self.navigationController = navigationController
        self.coordinatorDelegate = delegate
        self.delegate = delegate
        self.container = container
    }
    
    func start() {
        self.showSplash()
    }

    func showSplash() {
        let splashViewController = container.resolveViewController(SplashViewController.self)
        splashViewController.delegate = self
        self.navigationController.setViewControllers([splashViewController], animated: true)
    }
    
}

// MARK: - ViewControllerDelegate
extension SplashCoordinator: SplashViewControllerDelegate {
    func showLogin() {
        self.delegate?.showLogin(self)
    }
    
    func showHome() {
        self.delegate?.showHome(self)
    }
}
