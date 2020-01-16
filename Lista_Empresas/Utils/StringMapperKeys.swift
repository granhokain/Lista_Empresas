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
    
    struct CompanyKeys {
        
        static let id = "id"
        static let enterpriseName = "enterprise_name"
        static let description = "description"
        static let emailEnterprise = "email_enterprise"
        static let facebook = "facebook"
        static let twitter = "twitter"
        static let linkedin = "linkedin"
        static let phone = "phone"
        static let own_enterprise = "own_enterprise"
        static let photo = "photo"
        static let value = "value"
        static let shares = "shares"
        static let share_price = "share_price"
        static let own_shares = "own_shares"
        static let city = "city"
        static let country = "country"
        static let enterpriseType = "enterprise_type"
    }
    
    struct CompanyTypeKeys {
        static let id = "id"
        static let enterprise_type_name = "enterprise_type_name"
    }
    
    struct EnterpriseTypeKeys {
        static let enterprises = "enterprises"
    }
    
    struct FlowItemKeys {
        static let type = "type"
        static let content = "content"
    }
}

