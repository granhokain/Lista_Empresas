//
//  LoginPresenter.swift
//  Lista_Empresas
//
//  Created by Rafael Martins on 21/01/20.
//  Copyright © 2020 Rafael Martins. All rights reserved.
//

import Foundation
protocol LoginViewable: BaseView {
    func logedin(user: User)
    func errorRefreshToken()
    func showLogin()
    func successfulRequestLogin(user: User)
}

protocol LoginPresentable: PresenterMapable {
    var view: LoginViewable? { get set }
    
    func attachView(_ view: LoginViewable)
    func requestLogin(email: String, password: String)
    func getToken(code: String)
    func refreshToken(token: String)
    func verifySession()
    init(credentialManager: CredentialManageable, sessionManager: SessionManageable, authenticationService: Authenticable)
}


class LoginPresenter: LoginPresentable {
    
    weak var view: LoginViewable?
    
    private let credentialManager: CredentialManageable!
    private let sessionManager: SessionManageable!
    private let authenticationService: Authenticable!
    
    func attachView(_ view: LoginViewable) {
        self.view = view
    }
    
    required init(credentialManager: CredentialManageable, sessionManager: SessionManageable, authenticationService: Authenticable) {
        self.credentialManager = credentialManager
        self.sessionManager = sessionManager
        self.authenticationService = authenticationService
    }
    
    func requestLogin(email: String, password: String){
        view?.startLoading()
        authenticationService.login(email: email, password: password) { (userInvestor, error, cache) in
            self.view?.stopLoading()
            if let user = userInvestor {
                self.view?.showLogin()
                self.view?.successfulRequestLogin(user: user)
                
            } else if let error = error {
                self.view?.stopLoading()
                self.view?.showAlert(error.message!)
            }
        }
    }
    
    func getToken(code: String) {
        view?.startLoading()
        authenticationService.token(with: code) { (credential, error, cache) in
            if error == nil {
                self.credentialManager.save(credential!.accessToken, forKey: .tokenCompany)
                self.credentialManager.save(credential!.refreshToken, forKey: .refreshToken)
                self.authenticationService.userInfo(with: credential!) { (response, error, cache) in
                    if error == nil {
                        self.sessionManager.setUser(response!)
                        self.view?.logedin(user: response!)
                        self.updateNotificationToken()
                    } else {
                        if let error = error, let messageError = error.message {
                            self.view?.showAlert(messageError)
                        }
                        self.view?.showLogin()
                    }
                }
            } else {
                self.view?.showAlert(error!.message! )
            }
        }
    }
    
    func refreshToken(token: String) {
        view?.startLoading()
        authenticationService.refreshToken(with: token) { (credential, error, cache) in
            if error == nil {
                self.credentialManager.save(credential!.refreshToken, forKey: .refreshToken)
                self.credentialManager.save(credential!.accessToken, forKey: .tokenCompany)
                self.authenticationService.userInfo(with: credential!) { (response, error, cache) in
                    if error == nil {
                        self.view?.logedin(user: response!)
                        self.updateNotificationToken()
                    } else {
                        self.view?.errorRefreshToken()
                    }
                }
            } else {
                self.view?.errorRefreshToken()
            }
        }
    }

    func verifySession() {
        if sessionManager.isLoggedIn() {
            if let authorizationHeaderValue = credentialManager.retrive(.refreshToken) {
                self.refreshToken(token: authorizationHeaderValue)
            }
        } else {
            self.view?.showLogin()
        }
    }

    func updateNotificationToken() {
        authenticationService.updateNotificationToken(token: sessionManager.getNotificationToken()){ (message, error, cache) in
            if message != nil {
                debugPrint(message as Any)
            } else {
                debugPrint(error?.message as Any)
            }
        }
    }
}
