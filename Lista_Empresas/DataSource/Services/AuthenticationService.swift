//
//  LoginService.swift
//  Lista_Empresas
//
//  Created by Rafael Martins on 13/01/20.
//  Copyright © 2020 Rafael Martins. All rights reserved.
//

import Foundation

class AuthenticationService: APIRequest, Authenticable {

    let url = "https://empresas.ioasys.com.br/api/v1/users/auth/sign_in"
    
    func login(email: String, password: String, completion: APIRequest.EmpresasResponseBlock<User>?)-> AuthenticationService {
        let request = AuthenticationService(method: .post, path: url, parameters: ["email": email, "password": password], urlParameters: nil, cacheOption: .networkOnly) { (response, error, cache) in
            
            let companyError = CompanyError(response: response, error: error)
            
            if let userResponse = response as? JSONDictionary, companyError == nil {
                let user = User(dictionary: userResponse)
                completion?(user, nil, cache)
            } else {
                completion?(nil, companyError, cache)
            }
        }
        request.suppressErrorAlert = true
        request.shouldSaveInCache = false
        request.makeRequest()
        
        return request
    }

    func logout(completion: APIRequest.EmpresasResponseBlock<JSONDictionary>?) {
        let request = APIRequest(method: .delete, path: url, parameters: nil, urlParameters: nil, cacheOption: .networkOnly) { (response, error, cache) in

            let companyError = CompanyError(response: response, error: error)

            if let response = response as? JSONDictionary, error == nil {
                completion?(response, nil, cache)
            } else {
                completion?(nil, companyError, cache)
            }
        }
        request.suppressErrorAlert = true
        request.makeRequest()
    }
    
    
    func updateNotificationToken(token: String, completion: EmpresasResponseBlock<String>?) {
        let metaDectionary: JSONDictionary = ["device_id": token, "device_os": "ios"]
        let params = ["metadata": metaDectionary] as [String : Any]
        
        let request = AuthenticationService(method: .put, path: Statics.Strings.Urls.kUpdateNotificationToken, parameters: params, urlParameters: nil, cacheOption: .networkOnly) { (response, error, cache) in
            
            let companyError = CompanyError(response: response, error: error)
            
            if let messageResponse = response as? JSONDictionary, companyError == nil {
                let res = messageResponse["status"] as! String
                completion?(res, nil, cache)
            } else {
                completion?(nil, companyError, cache)
            }
        }
        request.shouldSaveInCache = false
        request.suppressErrorAlert = true
        request.makeRequest()
    }
    
    func token(with code: String, callback: EmpresasResponseBlock<Credential>?) {
           let request = APIRequest(method: .post, path: "token", parameters: ["grant_type": "authorization_code", "code": code, "redirect_uri": "myRedirectUri://callback"], urlParameters: nil, cacheOption: .networkOnly) { (response, error, cache) in
               
               let companyError = CompanyError(response: response, error: error)
               
               if let response = response as? JSONDictionary {
                   let credential = Credential(dictionary: response)
                   callback?(credential, nil, cache)
               } else {
                   callback?(nil, companyError, cache)
               }
           }
           request.extraHeaders = ["Content-Type": "application/x-www-form-urlencoded", "Authorization": "Basic RkRDNFU6RkRDNHVAMjAxOSE="]
           request.parameterEncoder = API.URLParameterEncoder.self
           //request.baseURL = APIConstants.identityServerBaseURL!
           request.suppressErrorAlert = true
           request.makeRequest()
    
       }
       
       func refreshToken(with token: String, callback: EmpresasResponseBlock<Credential>?) {
           let request = APIRequest(method: .post, path: "token", parameters: ["grant_type": "refresh_token", "refresh_token": token], urlParameters: nil, cacheOption: .networkOnly) { (response, error, cache) in
               
               let companyError = CompanyError(response: response, error: error)
               
               if let errorres = companyError {
                   callback?(nil, errorres, cache)
               } else {
                   if let responsedic = response as? JSONDictionary {
                       let credential = Credential(dictionary: responsedic)
                       callback?(credential, nil, cache)
                   } else {
                       callback?(nil, companyError, cache)
                   }
               }
           }
           request.extraHeaders = ["Content-Type": "application/x-www-form-urlencoded", "Authorization": "Basic RkRDNFU6RkRDNHVAMjAxOSE="]
           request.parameterEncoder = API.URLParameterEncoder.self
           //request.baseURL = APIConstants.identityServerBaseURL!
           request.suppressErrorAlert = true
           request.makeRequest()
       }
    
    func userInfo(with credential: Credential, callback: EmpresasResponseBlock<User>?) {
        let request = APIRequest(method: .post, path: Statics.Strings.Urls.kLogin, parameters: nil, urlParameters: nil, cacheOption: .networkOnly) { (response, error, cache) in
            
            let companyError = CompanyError(response: response, error: error)
            
            if let response = response as? JSONDictionary, error == nil {
                let user = User(dictionary: response)
                callback?(user, nil, cache)
            } else {
                callback?(nil, companyError, cache)
            }
        }
        request.suppressErrorAlert = true
        request.makeRequest()
    }
}
