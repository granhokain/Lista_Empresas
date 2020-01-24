//
//  CompanyDetailPresenter.swift
//  Lista_Empresas
//
//  Created by Rafael Martins on 24/01/20.
//  Copyright © 2020 Rafael Martins. All rights reserved.
//

import Foundation

protocol CompanyDetailViewable: BaseView {

}

protocol CompanyDetailPresentable: PresenterMapable {
    var view: CompanyDetailViewable? { get set }
    init(sessionManager: SessionManageable, profileService: CompanyServiceProtocol)
    func attachView(_ view: CompanyDetailViewable)
}

class CompanyDetailPresenter: CompanyDetailPresentable {
    
    weak var view: CompanyDetailViewable?
    
    private let sessionManager: SessionManageable!
    private let companyService: CompanyServiceProtocol!
    
    func attachView(_ view: CompanyDetailViewable) {
        self.view = view
    }
    
    required init(sessionManager: SessionManageable, profileService: CompanyServiceProtocol) {
        self.sessionManager = sessionManager
        self.companyService = profileService
    }
    
}
