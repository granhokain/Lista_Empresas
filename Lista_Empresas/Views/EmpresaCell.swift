//
//  EmpresaCell.swift
//  Lista_Empresas
//
//  Created by Rafael Martins on 15/01/20.
//  Copyright © 2020 Rafael Martins. All rights reserved.
//

import UIKit

class EmpresasCell: UITableViewCell {
    
    @IBOutlet weak var empresaImage: UIImageView!
    @IBOutlet weak var nomeEmpresaLabel: UILabel!
    @IBOutlet weak var paisEmpresaLabel: UILabel!
    @IBOutlet weak var tipoNegocioLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setImage()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setImage()
    }
    
    func setImage(){
        empresaImage.image = UIImage(named: "imgE1Lista")!
    }
    
    func set(company: Company) {
        nomeEmpresaLabel.text = company.enterpriseName
        paisEmpresaLabel.text = company.country
        tipoNegocioLabel.text = company.enterpriseType.enterprise_type_name
    }
}
