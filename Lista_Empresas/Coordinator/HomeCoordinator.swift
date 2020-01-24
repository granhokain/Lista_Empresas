//
//  HomeCoordinator.swift
//  Lista_Empresas
//
//  Created by Rafael Martins on 22/01/20.
//  Copyright © 2020 Rafael Martins. All rights reserved.
//

import Foundation
import Swinject

protocol HomeCoordinatorDelegate: CoordinatorDelegate {
    func showCompanyDetail(_ coordinator: HomeCoordinator, detail: String)

}

class HomeCoordinator: Coordinator {
    var container: Container
    weak var delegate: HomeCoordinatorDelegate?
    weak var coordinatorDelegate: CoordinatorDelegate?
    var childCoordinators: [Coordinator] = []
    var navigationController: BaseNavigationController
    
    init(navigationController: BaseNavigationController, container: Container, delegate: HomeCoordinatorDelegate) {
        self.navigationController = navigationController
        self.coordinatorDelegate = delegate
        self.delegate = delegate
        self.container = container
    }
    
    func start() {
        self.showHome()
    }
    
    func showHome() {
        let homeViewController = container.resolveViewController(CompanyListViewController.self)
        homeViewController.delegate = self
        self.navigationController.setViewControllers([homeViewController], animated: false)
    }
}

extension HomeCoordinator: CompanyListDelegate {
    func showCompanyDetail(from viewController: CompanyListViewController, detail: String) {
        self.delegate?.showCompanyDetail(self, detail: detail)
    }
}
