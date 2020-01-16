//
//  CompanyListPresenter.swift
//  Lista_Empresas
//
//  Created by Rafael Martins on 16/01/20.
//  Copyright © 2020 Rafael Martins. All rights reserved.
//

import Foundation

protocol CompanyListProtocol: AnyObject {
    func startLoading()
    func stopLoading()
    func successfulRequestCompanyList(company: Enterprises)
    func successfulRequestAllCompanyList(company: Enterprises)
    func showAlert(with message: String)
}

class CompanyListPresenter {
    weak private var companyView: CompanyListProtocol?
    let repository = CompanyService()
    
    func attachView(_ view: CompanyListProtocol) {
        self.companyView = view
    }
    
    func getCompanyRequest(with companyName: String) {
        self.companyView?.startLoading()
            repository.getCompany(companyName: companyName) { (company, error, cache) in
            self.companyView?.stopLoading()
            if let company = company {
                self.companyView?.successfulRequestCompanyList(company: company)
            } else if let error = error {
                self.companyView?.stopLoading()
                self.companyView?.showAlert(with: error.message!)
            }
        }
    }
    
    func getAllCompanyRequest() {
        self.companyView?.startLoading()
            repository.getAllCompany() { (company, error, cache) in
            self.companyView?.stopLoading()
            if let company = company {
                self.companyView?.successfulRequestAllCompanyList(company: company)
            } else if let error = error {
                self.companyView?.stopLoading()
                self.companyView?.showAlert(with: error.message!)
            }
        }
    }
}
