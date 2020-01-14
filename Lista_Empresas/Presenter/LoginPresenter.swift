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
    func successfulRequestLogin(user: InvestorLogin)
    func showAlert(with message: String)
}

class LoginPresenter {
    weak private var loginView: LoginProtocol?
    let repository = LoginService()
    
    func attachView(_ view: LoginProtocol) {
        self.loginView = view
    }
    
    func loginRequest(with email: String, password: String) {
        repository.requestLogin(email: email, senha: password, sucesso: { user in
            self.loginView?.successfulRequestLogin(user: user)
            print(user)
        }, falha: { erro in
            self.loginView?.showAlert(with: (erro))
            print(erro)
        })
    }
}
