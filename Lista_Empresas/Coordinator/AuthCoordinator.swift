//
//  AuthCoordinator.swift
//  Lista_Empresas
//
//  Created by Rafael Martins on 21/01/20.
//  Copyright © 2020 Rafael Martins. All rights reserved.
//

import UIKit
import Swinject

protocol AuthCoordinatorDelegate: CoordinatorDelegate {
    func showHome(_ coordinator: AuthCoordinator)
}

class AuthCoordinator: Coordinator {
    var container: Container
    weak var delegate: AuthCoordinatorDelegate?
    weak var coordinatorDelegate: CoordinatorDelegate?
    var childCoordinators: [Coordinator] = []
    var navigationController: BaseNavigationController
    
    init(navigationController: BaseNavigationController, container: Container, delegate: AuthCoordinatorDelegate) {
        self.navigationController = navigationController
        self.coordinatorDelegate = delegate
        self.delegate = delegate
        self.container = container
    }
    
    func start() {
        self.showLoginView()
    }
    
    func showLoginView() {
        let loginViewController = container.resolveViewController(LoginViewController.self)
        loginViewController.delegate = self
        self.navigationController.setViewControllers([loginViewController], animated: true)
    }
}

extension AuthCoordinator: LoginViewControllerDelegate {
    func showHome(from viewController: LoginViewController) {
            self.delegate?.showHome(self)
    }
    
    func logout(from viewController: LoginViewController) {
        
    }
}
