//
//  HomePresenter.swift
//  Lista_Empresas
//
//  Created by Rafael Martins on 22/01/20.
//  Copyright © 2020 Rafael Martins. All rights reserved.
//

import Foundation

protocol HomeViewable: BaseView {
    func successfulRequestCompanyList(company: Enterprises)
    func successfulRequestAllCompanyList(company: Enterprises)
}

protocol HomePresentable: PresenterMapable {
    var view: HomeViewable? { get set }
    init(sessionManager: SessionManageable, profileService: CompanyServiceProtocol)
    func attachView(_ view: HomeViewable)
    func getCompanyRequest(with companyName: String)
    func getAllCompanyRequest()
}

class HomePresenter: HomePresentable {
    
    weak var view: HomeViewable?
    
    private let sessionManager: SessionManageable!
    private let companyService: CompanyServiceProtocol!
    
    func attachView(_ view: HomeViewable) {
        self.view = view
    }
    
    required init(sessionManager: SessionManageable, profileService: CompanyServiceProtocol) {
        self.sessionManager = sessionManager
        self.companyService = profileService
    }
    
    func getCompanyRequest(with companyName: String) {
        self.view?.startLoading()
            self.companyService.getCompany(companyName: companyName) { (company, error, cache) in
            self.view?.stopLoading()
            if let company = company {
                self.view?.successfulRequestCompanyList(company: company)
            } else if let error = error {
                self.view?.stopLoading()
                self.view?.showAlert(error.message!)
            }
        }
    }
    
    func getAllCompanyRequest() {
        self.view?.startLoading()
            self.companyService.getAllCompany() { (company, error, cache) in
            self.view?.stopLoading()
            if let company = company {
                self.view?.successfulRequestAllCompanyList(company: company)
            } else if let error = error {
                self.view?.stopLoading()
                self.view?.showAlert(error.message!)
            }
        }
    }
    
}
