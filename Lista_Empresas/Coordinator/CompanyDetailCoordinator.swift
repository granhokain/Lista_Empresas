//
//  CompanyDetailCoordinator.swift
//  Lista_Empresas
//
//  Created by Rafael Martins on 24/01/20.
//  Copyright © 2020 Rafael Martins. All rights reserved.
//

import Foundation
import Swinject

protocol CompanyDetailCoordinatorDelegate: CoordinatorDelegate {
    func didLogout(on coordinator: CompanyDetailCoordinator)
}

class CompanyDetailCoordinator: Coordinator {
    var container: Container
    weak var delegate: CompanyDetailCoordinatorDelegate?
    weak var coordinatorDelegate: CoordinatorDelegate?
    var childCoordinators: [Coordinator] = []
    var navigationController: BaseNavigationController
    
    init(navigationController: BaseNavigationController, container: Container, delegate: CompanyDetailCoordinatorDelegate) {
        self.navigationController = navigationController
        self.coordinatorDelegate = delegate
        self.delegate = delegate
        self.container = container
    }
    
    func start() {
        self.showCompanyDetail()
    }
    
    func showCompanyDetail() {
        let companyDetailsViewController = container.resolveViewController(CompanyDetailsViewController.self)
        companyDetailsViewController.delegate = self
        self.navigationController.setViewControllers([companyDetailsViewController], animated: false)
    }
}

extension CompanyDetailCoordinator: CompanyDetailsDelegate {
    func didLogout(on coordinator: HomeCoordinator) {
        self.delegate?.didLogout(on: self)
    }
}
