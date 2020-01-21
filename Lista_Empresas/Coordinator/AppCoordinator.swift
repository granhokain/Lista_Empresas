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
        
    }
}
