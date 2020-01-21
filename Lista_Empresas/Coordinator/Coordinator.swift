//
//  Coordinator.swift
//  Lista_Empresas
//
//  Created by Rafael Martins on 20/01/20.
//  Copyright © 2020 Rafael Martins. All rights reserved.
//

import UIKit

protocol CoordinatorDelegate: class {
    func coordinatorDidExit(_ coordinator: Coordinator)
}

protocol Coordinator: CoordinatorDelegate {
    var coordinatorDelegate: CoordinatorDelegate? { get set }
    var childCoordinators: [Coordinator] { get set }
    var navigationController: BaseNavigationController { get set }
    
    func start()
}

extension Coordinator {
    func coordinatorDidExit(_ coordinator: Coordinator) {
        guard let index = self.childCoordinators.firstIndex(where: { $0 === coordinator }) else { return }
        self.childCoordinators.remove(at: index)
    }
}
