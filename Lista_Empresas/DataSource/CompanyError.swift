//
//  EmpresasError.swift
//  Lista_Empresas
//
//  Created by Rafael Martins on 14/01/20.
//  Copyright © 2020 Rafael Martins. All rights reserved.
//

import Foundation

enum CompanyTypeError {
    case connection, server, custom
}

class CompanyError {
    var code: Int!
    var message: String!
    var type: CompanyTypeError!
    
    init?(response: Any?, error: API.RequestError?) {
        
        if response == nil {
            verifyConnection(error)
        } else {
            type = .custom
            self.message = error?.errorDescription ?? ""
            if let error = error?.urlResponse {
                verifyErrors(error)
            } else {
                if let _ = response as? JSONDictionary, error == nil  { // OK - sem erro
                    return nil
                } else if let _ = response as? JSONArray, error == nil { // OK - sem error
                    return nil
                } else if error == nil  { // sem erro
                    return nil
                }
            }
        }
    }
    
    
    fileprivate func verifyConnection(_ error: API.RequestError?) {
        if let error = error?.originalError, error._code == -1009 || error._code == -1001 {
            code = error._code
            message = "Sem conexão"
            type = .connection
        }
    }
    
    fileprivate func verifyErrors(_ error: HTTPURLResponse) {
        code = error.statusCode
        if error.statusCode >= 500 {
            message = "Internal server error"
            type = .server
        } else if error.statusCode == 401 {
            message = "Unauthorized"
            type = .server
        } else if error.statusCode == 400 {
            message = "Bad request"
            type = .server
        }
    }
    
}
