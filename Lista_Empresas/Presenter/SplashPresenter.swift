//
//  SplashPresenter.swift
//  Lista_Empresas
//
//  Created by Rafael Martins on 21/01/20.
//  Copyright © 2020 Rafael Martins. All rights reserved.
//

import Foundation

import Foundation

protocol SplashViewable: AnyObject {
    func showHomeView()
    func showLoginView()
}

protocol SplashPresentable: PresenterMapable {
    var view: SplashViewable? { get set }
    init(sessionManager: SessionManageable)
    func attachView(_ view: SplashViewable)
    func verifySession()
}

class SplashPresenter: SplashPresentable {

    private let sessionManager: SessionManageable!

    weak var view: SplashViewable?

    func attachView(_ view: SplashViewable) {
        self.view = view
    }

    required init(sessionManager: SessionManageable) {
        self.sessionManager = sessionManager
    }

    func verifySession() {
        if sessionManager.isLoggedIn() {
            self.view?.showHomeView()
        } else {
            self.view?.showLoginView()
        }
    }

}
