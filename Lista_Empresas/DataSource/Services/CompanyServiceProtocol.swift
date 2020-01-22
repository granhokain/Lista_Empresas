//
//  CompanyServiceProtocol.swift
//  Lista_Empresas
//
//  Created by Rafael Martins on 22/01/20.
//  Copyright © 2020 Rafael Martins. All rights reserved.
//

import Foundation

protocol CompanyServiceProtocol: class {
    func getCompany(companyName: String, completion: APIRequest.EmpresasResponseBlock<Enterprises>?)-> CompanyService
    func getAllCompany(completion: APIRequest.EmpresasResponseBlock<Enterprises>?)-> CompanyService
}
