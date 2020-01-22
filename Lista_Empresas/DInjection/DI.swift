//
//  DI.swift
//  Lista_Empresas
//
//  Created by Rafael Martins on 21/01/20.
//  Copyright © 2020 Rafael Martins. All rights reserved.
//

import Foundation
import UIKit
import Swinject
import SwinjectAutoregistration
import SwinjectStoryboard

extension AppDelegate {
    
    func setupDependencyInjection() {
        resolveSplash()
        resolveLogin()
    }
    
    func resolveSplash() {
        container.register(SessionManageable.self) {_ in SessionManager() }
        container.autoregister(SplashPresentable.self, initializer: SplashPresenter.init)

        container.storyboardInitCompleted(SplashViewController.self) { (resolver, controller) in
            let presenter = resolver.resolve(SplashPresentable.self)
            presenter?.attachView(controller)
            controller.splashPresenter = presenter
        }
    }
    
    func resolveLogin() {
        container.register(CredentialManageable.self) {_ in CredentialManager() }
        container.register(Authenticable.self) {_ in AuthenticationService() }
        container.autoregister(LoginPresentable.self, initializer: LoginPresenter.init)
        
        container.storyboardInitCompleted(LoginViewController.self) { (resolver, controller) in
            let presenter = resolver.resolve(LoginPresentable.self)
            presenter?.attachView(controller)
            controller.loginPresenter = presenter
        }
    }
    
    func resolveHome() {
        container.register(CompanyServiceProtocol.self) {_ in CompanyService() }
        container.autoregister(HomePresentable.self, initializer: HomePresenter.init)
        
        container.storyboardInitCompleted(CompanyListViewController.self) { (resolver, controller) in
            let presenter = resolver.resolve(HomePresentable.self)
            presenter?.attachView(controller)
            controller.homePresenter = presenter
        }
    }
}
