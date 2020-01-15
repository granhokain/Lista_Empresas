//
//  Authenticable.swift
//  Lista_Empresas
//
//  Created by Rafael Martins on 14/01/20.
//  Copyright © 2020 Rafael Martins. All rights reserved.
//

import Foundation

protocol Authenticable: class {
    func login(email: String, password: String, completion: APIRequest.FDCResponseBlock<User>?)
    func logout(completion: APIRequest.FDCResponseBlock<JSONDictionary>?)
}
