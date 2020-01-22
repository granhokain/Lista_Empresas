//
//  PresenterMapable.swift
//  Lista_Empresas
//
//  Created by Rafael Martins on 21/01/20.
//  Copyright © 2020 Rafael Martins. All rights reserved.
//

import Foundation

protocol PresenterMapable {
    func map(_ error: CompanyError, view: BaseView?)
}

extension PresenterMapable {
    func map(_ error: CompanyError, view: BaseView?) {
        guard let view = view else { return }
        view.stopLoading()
        guard let safeErroType = error.type else { return }
        
        switch safeErroType {
        case .connection:
            view.showConnectionError(error.message)
        case .server:
            view.showAlert(error.message)
        case .custom:
            view.showAlert(error.message)
        }
    }
}
