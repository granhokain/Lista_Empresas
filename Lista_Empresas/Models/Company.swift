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
    //var emailEnterprise: String?
    //var facebook: String?
    //var twitter: String?
    //var linkedin: String?
    //var phone: String?
    var own_enterprise: Bool
    //var photo: String?
    var value: Int
    //var shares: Int
    var share_price: Double
    //var own_shares: Int
    var city: String
    var country: String
    var enterpriseType: CompanyType

  init(mapper: Mapper) {
    self.id = mapper.keyPath(StringMapperKeys.CompanyKeys.id)
    self.enterpriseName = mapper.keyPath(StringMapperKeys.CompanyKeys.enterpriseName)
    self.description = mapper.keyPath(StringMapperKeys.CompanyKeys.description)
    //self.emailEnterprise = mapper.keyPath(StringMapperKeys.CompanyKeys.emailEnterprise)
    //self.facebook = mapper.keyPath(StringMapperKeys.CompanyKeys.facebook)
    //self.twitter = mapper.keyPath(StringMapperKeys.CompanyKeys.twitter)
    //self.linkedin = mapper.keyPath(StringMapperKeys.CompanyKeys.linkedin)
    //self.phone = mapper.keyPath(StringMapperKeys.CompanyKeys.phone)
    self.own_enterprise = mapper.keyPath(StringMapperKeys.CompanyKeys.own_enterprise)
    //self.photo = mapper.keyPath(StringMapperKeys.CompanyKeys.photo)
    self.value = mapper.keyPath(StringMapperKeys.CompanyKeys.value)
    //self.shares = mapper.keyPath(StringMapperKeys.CompanyKeys.shares)
    self.share_price = mapper.keyPath(StringMapperKeys.CompanyKeys.share_price)
    //self.own_shares = mapper.keyPath(StringMapperKeys.CompanyKeys.own_shares)
    self.city = mapper.keyPath(StringMapperKeys.CompanyKeys.city)
    self.country = mapper.keyPath(StringMapperKeys.CompanyKeys.country)
    self.enterpriseType = mapper.keyPath(StringMapperKeys.CompanyKeys.enterpriseType)
  }
  
  init() {
    self.id = 0
    self.enterpriseName = ""
    self.description = ""
    //self.emailEnterprise = ""
    //self.facebook = ""
    //self.twitter = ""
    //self.linkedin = ""
    //self.phone = ""
    self.own_enterprise = false
    //self.photo = ""
    self.value = 0
    //self.shares = 0
    self.share_price = 0.0
    //self.own_shares = 0
    self.city = ""
    self.country = ""
    self.enterpriseType = CompanyType()
  }
  
}
