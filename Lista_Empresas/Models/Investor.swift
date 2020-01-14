//
//  Investor.swift
//  Lista_Empresas
//
//  Created by Rafael Martins on 13/01/20.
//  Copyright © 2020 Rafael Martins. All rights reserved.
//

import Foundation
struct Investor: Codable {
    
    var id: Int
    var investor_name: String
    var email: String
    var city: String
    var country: String
    var balance: Double
    var photo: String
    var portfolio_value: Double
    var first_access: Bool
    var super_angel: Bool
    var portfolio: Portfolio
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case investor_name = "investor_name"
        case email = "email"
        case city = "city"
        case country = "country"
        case balance = "balance"
        case photo = "photo"
        case portfolio_value = "portfolio_value"
        case first_access = "first_access"
        case super_angel = "super_angel"
        case portfolio = "portfolio"
    }
}

struct Portfolio: Codable {
    let enterprises_number: Int
    let enterprises: [String]
}
