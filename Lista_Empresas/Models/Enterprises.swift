//
//  Enterprises.swift
//  Lista_Empresas
//
//  Created by Rafael Martins on 16/01/20.
//  Copyright © 2020 Rafael Martins. All rights reserved.
//

import Foundation

struct Enterprises: Mappable {
    
    var enterprises: [Company]


  init(mapper: Mapper) {
    self.enterprises = mapper.keyPath(StringMapperKeys.EnterpriseTypeKeys.enterprises)

  }
  
  init() {
    self.enterprises = [Company]()
  }
  
}
