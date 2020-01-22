//
//  ContainerExtension.swift
//  Lista_Empresas
//
//  Created by Rafael Martins on 22/01/20.
//  Copyright © 2020 Rafael Martins. All rights reserved.
//

import Foundation
import SwinjectStoryboard
import Swinject

extension Container {
    /**
     Retrieves UIViewController of the specified type. The UIViewController must conform to StoryboardLodable
     
     - Parameter serviceType: UIViewController type
     - Returns: UIViewController of specified type
     */
    func resolveViewController<ViewController: StoryboardLodable>(_ serviceType: ViewController.Type) -> ViewController {
        let sb = SwinjectStoryboard.create(name: serviceType.storyboardName, bundle: nil, container: self)
        let viewController = "\(serviceType)"
        return sb.instantiateViewController(withIdentifier: viewController) as! ViewController
    }
}
