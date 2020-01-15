//
//  LoginPresenter.swift
//  Lista_Empresas
//
//  Created by Rafael Martins on 13/01/20.
//  Copyright © 2020 Rafael Martins. All rights reserved.
//

import Foundation

protocol LoginProtocol: AnyObject {
    func startLoading()
    func stopLoading()
    func successfulRequestLogin(user: User)
    func showAlert(with message: String)
}

class LoginPresenter {
    weak private var loginView: LoginProtocol?
    let repository = AuthenticationService()
    
    func attachView(_ view: LoginProtocol) {
        self.loginView = view
    }
    
    func loginRequest(with email: String, password: String) {
        self.loginView?.startLoading()
        repository.login(email: email, password: password) { (userInvestor, error, cache) in
            self.loginView?.stopLoading()
            if let user = userInvestor {
                self.loginView?.successfulRequestLogin(user: user)

            } else if let error = error {
                self.loginView?.stopLoading()
                self.loginView?.showAlert(with: error.message!)
            }
        }
    }
}
