//
//  Coordinator.swift
//  Lista_Empresas
//
//  Created by Rafael Martins on 08/12/19.
//  Copyright © 2019 Rafael Martins. All rights reserved.
//

import Foundation
import UIKit

final class Coordinator {
    
    let viewController = ListaViewController()
    
    func showListScreen(){
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        viewController.dismiss(animated: true, completion: nil)
        
        let listaVC = storyboard.instantiateViewController(withIdentifier: "listaEmpresas") as! ListaViewController
        
        viewController.present(listaVC, animated: true, completion: nil)
        
    }
}
