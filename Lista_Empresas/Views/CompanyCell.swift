//
//  EmpresaCell.swift
//  Lista_Empresas
//
//  Created by Rafael Martins on 15/01/20.
//  Copyright © 2020 Rafael Martins. All rights reserved.
//

import UIKit

class CompanyCell: UITableViewCell {
    
    @IBOutlet weak var companyImage: UIImageView!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var companyCountryLabel: UILabel!
    @IBOutlet weak var businessType: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setImage()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setImage()
    }
    
    func setImage(){
        
    }
    
    func set(company: Company) {
        companyNameLabel.text = company.enterpriseName
        companyCountryLabel.text = company.country
        businessType.text = company.enterpriseType.enterprise_type_name
    }
}
