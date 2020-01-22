//
//  BaseView.swift
//  Lista_Empresas
//
//  Created by Rafael Martins on 21/01/20.
//  Copyright © 2020 Rafael Martins. All rights reserved.
//

import Foundation

protocol BaseView: AnyObject {
    func startLoading()
    func stopLoading()
    func showConnectionError(_ message: String)
    func showAlert(_ message: String)
}
