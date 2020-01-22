//
//  Authenticable.swift
//  Lista_Empresas
//
//  Created by Rafael Martins on 14/01/20.
//  Copyright © 2020 Rafael Martins. All rights reserved.
//

import Foundation

protocol Authenticable: class {
    func login(email: String, password: String, completion: APIRequest.EmpresasResponseBlock<User>?)-> AuthenticationService
    func updateNotificationToken(token: String, completion: APIRequest.EmpresasResponseBlock<String>?)
    func logout(completion: APIRequest.EmpresasResponseBlock<JSONDictionary>?)
    func token(with code: String, callback: APIRequest.EmpresasResponseBlock<Credential>?)
    func refreshToken(with token: String, callback: APIRequest.EmpresasResponseBlock<Credential>?)
    func userInfo(with credential: Credential, callback: APIRequest.EmpresasResponseBlock<User>?)
}
