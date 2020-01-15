//
//  LoginService.swift
//  Lista_Empresas
//
//  Created by Rafael Martins on 13/01/20.
//  Copyright © 2020 Rafael Martins. All rights reserved.
//

import Foundation

class AuthenticationService: APIRequest {
    
    let url = "https://empresas.ioasys.com.br/api/v1/users/auth/sign_in"
    
    func login(email: String, password: String, completion: FDCResponseBlock<User>?)-> AuthenticationService {
        let request = AuthenticationService(method: .post, path: url, parameters: ["email": email, "password": password], urlParameters: nil, cacheOption: .networkOnly) { (response, error, cache) in
            
            let fdcError = FDCError(response: response, error: error)
            
            if let userResponse = response as? JSONDictionary, fdcError == nil {
                let user = User(dictionary: userResponse)
                completion?(user, nil, cache)
            } else {
                completion?(nil, fdcError, cache)
            }
        }
        request.suppressErrorAlert = true
        request.shouldSaveInCache = false
        request.makeRequest()
        
        return request
    }

    func logout(completion: APIRequest.FDCResponseBlock<JSONDictionary>?) {
        let request = APIRequest(method: .delete, path: url, parameters: nil, urlParameters: nil, cacheOption: .networkOnly) { (response, error, cache) in

            let fdcError = FDCError(response: response, error: error)

            if let response = response as? JSONDictionary, error == nil {
                completion?(response, nil, cache)
            } else {
                completion?(nil, fdcError, cache)
            }
        }
        request.suppressErrorAlert = true
        request.makeRequest()
    }
}
