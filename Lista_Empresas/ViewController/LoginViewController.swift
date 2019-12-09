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
    
    @IBOutlet weak var senhaTextField: UITextField!
    
    let repositorio = Repository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func loginButton(_ sender: Any) {
        let typedEmail = emailTextField.text
        let typedPassword = senhaTextField.text
        guard let email = typedEmail, let password = typedPassword else {
            return
        }
        
        repositorio.requestLogin(email: email, senha: password);
    }
    
}

