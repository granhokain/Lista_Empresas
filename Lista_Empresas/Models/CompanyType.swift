//
//  CompanyType.swift
//  Lista_Empresas
//
//  Created by Rafael Martins on 15/01/20.
//  Copyright © 2020 Rafael Martins. All rights reserved.
//

import Foundation

struct CompanyType: Mappable {
    
    var id: Int
    var enterprise_type_name: String


  init(mapper: Mapper) {
    self.id = mapper.keyPath(StringMapperKeys.CompanyTypeKeys.id)
    self.enterprise_type_name = mapper.keyPath(StringMapperKeys.CompanyTypeKeys.enterprise_type_name)
  }
  
  init() {
    self.id = 0
    self.enterprise_type_name = ""
  }
  
}
