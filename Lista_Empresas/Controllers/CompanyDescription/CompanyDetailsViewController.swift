//
//  CompanyDetailsViewController.swift
//  Lista_Empresas
//
//  Created by Rafael Martins on 20/01/20.
//  Copyright © 2020 Rafael Martins. All rights reserved.
//

import UIKit

protocol CompanyDetailsDelegate: class {
    func didLogout(on coordinator: HomeCoordinator)
}

class CompanyDetailsViewController: UIViewController, CompanyDetailsStoryboardLodable {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var detailCompanyImage: UIImageView!
    @IBOutlet weak var companyDetail: UILabel!
    
    var companyDetailPresentable: CompanyDetailPresentable!
    weak var delegate: CompanyDetailsDelegate?
    var companyDescription: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        companyDetail.text = companyDescription
    }
    
    @IBAction func backListButton(_ sender: UIButton) {
        //coordinator.backScreen(viewController: self)
    }
}

extension CompanyDetailsViewController: CompanyDetailViewable{
    
    func startLoading() {}
    
    func stopLoading() {}
    
    func showConnectionError(_ message: String) {}
    
    func showAlert(_ message: String) {}

}


