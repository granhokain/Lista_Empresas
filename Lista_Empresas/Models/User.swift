//
//  User.swift
//  Lista_Empresas
//
//  Created by Rafael Martins on 14/01/20.
//  Copyright © 2020 Rafael Martins. All rights reserved.
//

import Foundation

struct User: Mappable {
    
    var investor: Investor
    var enterprise: String?
    var success: Bool

  init(mapper: Mapper) {
    self.enterprise = mapper.keyPath(StringMapperKeys.UserKeys.enterprise)
    self.success = mapper.keyPath(StringMapperKeys.UserKeys.success)
    self.investor = mapper.keyPath(StringMapperKeys.UserKeys.investor)
    
  }
  
  init() {
    self.enterprise = ""
    self.success = false
    self.investor = Investor()
  }
  
}

