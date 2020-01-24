//
//  ViewController.swift
//  Lista_Empresas
//
//  Created by Rafael Martins on 05/12/19.
//  Copyright © 2019 Rafael Martins. All rights reserved.
//

import UIKit

protocol LoginViewControllerDelegate: class {
    func showHome(from viewController: LoginViewController)
    func logout(from viewController: LoginViewController)
}

class LoginViewController: UIViewController, LoginStoryboardLodable {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    weak var delegate: LoginViewControllerDelegate!
    var loginPresenter: LoginPresentable!
    var hasToken: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadingIndicator.hidesWhenStopped = true
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DismissKeyboard))
        view.addGestureRecognizer(tap)
        
        loginPresenter = LoginPresenter(credentialManager: CredentialManager(), sessionManager: SessionManager(), authenticationService: AuthenticationService())
        
        loginPresenter.attachView(self)
        loginPresenter.verifySession()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    @IBAction func loginButton(_ sender: Any) {
        let typedEmail = emailTextField.text
        let typedPassword = passwordTextField.text
        guard let email = typedEmail, let password = typedPassword else {
            return
        }
        
        loginPresenter.requestLogin(email: email, password: password)
    }
    
    @objc func DismissKeyboard(){
    view.endEditing(true)
    }
}

extension LoginViewController: LoginViewable {
    func successfulRequestLogin(user: User) {
        self.delegate.showHome(from: self)
    }
    
    func startLoading() {
        loadingIndicator.startAnimating()
    }
    
    func stopLoading() {
        loadingIndicator.stopAnimating()
    }
    
    func logedin(user: User) {}
    
    func errorRefreshToken() {
        self.delegate.logout(from: self)
    }
    
    func showAlert(_ message: String) {
        let message = "Não foi possível realizar o login. Tente novamente mais tarde."
        let alert = UIAlertController(title: "Algo deu errado…", message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .cancel) { _ in }
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showConnectionError(_ message: String) {}
    
    func showLogin() {}
}
