//
//  CompanyDetailsViewController.swift
//  Lista_Empresas
//
//  Created by Rafael Martins on 20/01/20.
//  Copyright © 2020 Rafael Martins. All rights reserved.
//

import UIKit

class CompanyDetailsViewController: UIViewController {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var detailCompanyImage: UIImageView!
    @IBOutlet weak var companyDetail: UILabel!
    
    fileprivate var coordinator = LoginCoordinator()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func backListButton(_ sender: UIButton) {
        coordinator.backScreen(viewController: self)
    }
    
    
}

extension CompanyDetailsViewController: CompanyListDelegate {
    func setCompanyDetails(detail: String) {
        print("teste")
        companyDetail.text = detail
    }
}
