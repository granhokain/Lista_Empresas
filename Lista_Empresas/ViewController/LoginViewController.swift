//
//  ViewController.swift
//  Lista_Empresas
//
//  Created by Rafael Martins on 05/12/19.
//  Copyright © 2019 Rafael Martins. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var senhaTextField: UITextField!
    
    var loginPresenter = LoginPresenter()
    var coordinator = Coordinator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginPresenter.attachView(self)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    @IBAction func loginButton(_ sender: Any) {
        let typedEmail = emailTextField.text
        let typedPassword = senhaTextField.text
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
        print("COMEÇOU CARREGAR")
        self.showHUD()
    }
    
    func stopLoading() {
        print("TERMINOU DE CARREGAR")
        self.hideHUD()
    }
    
    func successfulRequestLogin(user: User) {
        print("Resultado: \(user)")
        coordinator.showListScreen()
    }
    
    func showAlert(with message: String) {
        self.showAlertBar(message: message)
    }
    
    
}

