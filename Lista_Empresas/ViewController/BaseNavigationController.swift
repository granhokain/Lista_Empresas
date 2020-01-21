//
//  BaseNavigationController.swift
//  Lista_Empresas
//
//  Created by Rafael Martins on 20/01/20.
//  Copyright © 2020 Rafael Martins. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setDefault()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        get {
            return self.topViewController?.preferredStatusBarStyle ?? .lightContent
        }
    }
    
    func setDefault() {
        //self.navigationBar.setValue(true, forKey: "hidesShadow")
        self.navigationBar.isTranslucent = false
        self.navigationBar.barTintColor = Colors.tabBarColor
    }
}

