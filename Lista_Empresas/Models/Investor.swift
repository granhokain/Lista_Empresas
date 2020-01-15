//
//  Investor.swift
//  Lista_Empresas
//
//  Created by Rafael Martins on 13/01/20.
//  Copyright © 2020 Rafael Martins. All rights reserved.
//

import Foundation

struct Investor: Mappable {
    
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
    //var portfolio: Portfolio

  init(mapper: Mapper) {
    self.id = mapper.keyPath(StringMapperKeys.InvestorKeys.id)
    self.investor_name = mapper.keyPath(StringMapperKeys.InvestorKeys.investor_name)
    self.email = mapper.keyPath(StringMapperKeys.InvestorKeys.email)
    self.city = mapper.keyPath(StringMapperKeys.InvestorKeys.city)
    self.country = mapper.keyPath(StringMapperKeys.InvestorKeys.country)
    self.balance = mapper.keyPath(StringMapperKeys.InvestorKeys.balance)
    self.photo = mapper.keyPath(StringMapperKeys.InvestorKeys.photo)
    self.portfolio_value = mapper.keyPath(StringMapperKeys.InvestorKeys.portfolio_value)
    self.first_access = mapper.keyPath(StringMapperKeys.InvestorKeys.first_access)
    self.super_angel = mapper.keyPath(StringMapperKeys.InvestorKeys.super_angel)
  }
  
  init() {
    self.id = 0
    self.investor_name = ""
    self.email = ""
    self.city = ""
    self.country = ""
    self.email = ""
    self.photo = ""
    self.balance = 0.0
    self.portfolio_value = 0.0
    self.first_access = false
    self.super_angel = false
  }
  
}
