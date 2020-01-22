//
//  Company.swift
//  Lista_Empresas
//
//  Created by Rafael Martins on 15/01/20.
//  Copyright © 2020 Rafael Martins. All rights reserved.
//

import Foundation

struct Company: Mappable {
    
    var id: Int
    var enterpriseName: String?
    var description: String?
    var own_enterprise: Bool
    var value: Int
    var share_price: Double
    var city: String
    var country: String
    var enterpriseType: CompanyType

  init(mapper: Mapper) {
    self.id = mapper.keyPath(StringMapperKeys.CompanyKeys.id)
    self.enterpriseName = mapper.keyPath(StringMapperKeys.CompanyKeys.enterpriseName)
    self.description = mapper.keyPath(StringMapperKeys.CompanyKeys.description)
    self.own_enterprise = mapper.keyPath(StringMapperKeys.CompanyKeys.own_enterprise)
    self.value = mapper.keyPath(StringMapperKeys.CompanyKeys.value)
    self.share_price = mapper.keyPath(StringMapperKeys.CompanyKeys.share_price)
    self.city = mapper.keyPath(StringMapperKeys.CompanyKeys.city)
    self.country = mapper.keyPath(StringMapperKeys.CompanyKeys.country)
    self.enterpriseType = mapper.keyPath(StringMapperKeys.CompanyKeys.enterpriseType)
  }
  
  init() {
    self.id = 0
    self.enterpriseName = ""
    self.description = ""
    self.own_enterprise = false
    self.value = 0
    self.share_price = 0.0
    self.city = ""
    self.country = ""
    self.enterpriseType = CompanyType()
  }
  
}
