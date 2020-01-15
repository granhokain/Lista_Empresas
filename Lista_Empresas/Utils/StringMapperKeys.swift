//
//  StringMapperKeys.swift
//  Lista_Empresas
//
//  Created by Rafael Martins on 14/01/20.
//  Copyright © 2020 Rafael Martins. All rights reserved.
//

import Foundation

struct StringMapperKeys {
    
    struct UserKeys {
        static let investor = "investor"
        static let enterprise = "enterprise"
        static let success = "success"
    }
    
    struct InvestorKeys {
        
        static let id = "id"
        static let investor_name = "investor_name"
        static let email = "email"
        static let city = "city"
        static let country = "country"
        static let balance = "balance"
        static let photo = "photo"
        static let portfolio_value = "portfolio_value"
        static let first_access = "first_access"
        static let super_angel = "super_angel"
        static let portfolio = "portfolio"
    }
    
    struct FlowItemKeys {
        static let type = "type"
        static let content = "content"
    }
}

