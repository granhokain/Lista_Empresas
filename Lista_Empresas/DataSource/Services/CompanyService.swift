//
//  CompanyService.swift
//  Lista_Empresas
//
//  Created by Rafael Martins on 16/01/20.
//  Copyright © 2020 Rafael Martins. All rights reserved.
//

import Foundation

class CompanyService: APIRequest, CompanyServiceProtocol {
    
    let url = "https://empresas.ioasys.com.br/api/v1/enterprises"
    
    func getCompany(companyName: String, completion: EmpresasResponseBlock<Enterprises>?)-> CompanyService {
        let params = ["name": companyName] as [String: Any]
        let request = CompanyService(method: .get, path: url, parameters: nil, urlParameters: params, cacheOption: .networkOnly) { (response, error, cache) in
            
            let fdcError = CompanyError(response: response, error: error)
            
            if let userResponse = response as? JSONDictionary, fdcError == nil {
                let companyRequest = Enterprises(dictionary: userResponse)
                completion?(companyRequest, nil, cache)
            } else {
                completion?(nil, fdcError, cache)
            }
        }
        request.suppressErrorAlert = true
        request.shouldSaveInCache = false
        request.makeRequest()
        
        return request
    }

    func getAllCompany(completion: EmpresasResponseBlock<Enterprises>?)-> CompanyService {
        let request = CompanyService(method: .get, path: url, parameters: nil, urlParameters: nil, cacheOption: .networkOnly) { (response, error, cache) in
            
            let fdcError = CompanyError(response: response, error: error)
            
            if let userResponse = response as? JSONDictionary, fdcError == nil {
                let company = Enterprises(dictionary: userResponse)
                completion?(company, nil, cache)
            } else {
                completion?(nil, fdcError, cache)
            }
        }
        request.suppressErrorAlert = true
        request.shouldSaveInCache = false
        request.makeRequest()
        
        return request
    }
}
