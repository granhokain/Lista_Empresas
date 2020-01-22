//
//  Credential.swift
//  Lista_Empresas
//
//  Created by Rafael Martins on 22/01/20.
//  Copyright © 2020 Rafael Martins. All rights reserved.
//

import Foundation

struct Credential: Mappable {

    var expiresIn: String!
    var tokenType: String!
    var accessToken: String!
    var idToken: String!
    var refreshToken: String!
    
    init(mapper: Mapper) {
        expiresIn = mapper.keyPath("expires_in")
        tokenType = mapper.keyPath("token_type")
        accessToken = mapper.keyPath("access_token")
        idToken = mapper.keyPath("id_token")
        refreshToken = mapper.keyPath("refresh_token")
    }
}
