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

    func showListScreen(viewController: UIViewController){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "listaEmpresas")
        controller.modalPresentationStyle = .fullScreen
        viewController.present(controller, animated: true, completion: nil)
    }
    
    func showDetailScreen(viewController: UIViewController){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "companyDatails")
        controller.modalPresentationStyle = .fullScreen
        viewController.present(controller, animated: true, completion: nil)
    }
    
    func backScreen(viewController: UIViewController){
        viewController.dismiss(animated: true, completion: nil)
    }
}
