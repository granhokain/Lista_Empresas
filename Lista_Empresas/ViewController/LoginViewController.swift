//
//  ViewController.swift
//  Lista_Empresas
//
//  Created by Rafael Martins on 05/12/19.
//  Copyright © 2019 Rafael Martins. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    var loginPresenter = LoginPresenter()
    var coordinator = LoginCoordinator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingIndicator.hidesWhenStopped = true
        loginPresenter.attachView(self)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DismissKeyboard))
        view.addGestureRecognizer(tap)
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
        
        loginPresenter.loginRequest(with: email, password: password)
    }
    
    @objc func DismissKeyboard(){
    view.endEditing(true)
    }
}

extension LoginViewController: LoginProtocol {
    func startLoading() {
        loadingIndicator.startAnimating()
    }
    
    func stopLoading() {
        loadingIndicator.stopAnimating()
    }
    
    func successfulRequestLogin(user: User) {
        coordinator.showListScreen(viewController: self)
    }
    
    func showAlert(with message: String) {
        let message = "Não foi possível realizar o login. Tente novamente mais tarde."
        let alert = UIAlertController(title: "Algo deu errado…", message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .cancel) { _ in }
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    
    
}

