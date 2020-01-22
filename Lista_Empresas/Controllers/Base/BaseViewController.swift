//
//  BaseViewController.swift
//  Lista_Empresas
//
//  Created by Rafael Martins on 21/01/20.
//  Copyright © 2020 Rafael Martins. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    @IBInspectable var translucentNavBar: Bool = false
    @IBInspectable var navBarTitleFontSize: CGFloat = 16.0
    @IBInspectable var navBarTitleFontName: String = "NexaSlabBoldFREE"
    @IBInspectable var navBarColor: UIColor = Colors.navBarColor
    
    func hiddenNavigationController(_ hidden: Bool, animated: Bool = true) {
        self.navigationController?.setNavigationBarHidden(hidden, animated: animated)
    }
    
    
    func setupNavBarTransparency() {
        if let navController = navigationController {
            navController.navigationBar.backgroundColor = .clear
            navController.navigationBar.isTranslucent = translucentNavBar
        }
    }
    
    func setupNavBarColor(color: UIColor) {
        self.navigationController?.navigationBar.barTintColor = color
        self.navigationController?.navigationBar.tintColor = color
    }
    
    
    func setupNavBarBottomBorderColor() {
        if let navController = navigationController {
            let image = UIImage()
            navController.navigationBar.shadowImage = image
            navController.navigationBar.setBackgroundImage(image, for: UIBarMetrics.default)
        }
    }
    
    func setupTitleTopSpace(space: CGFloat) {
        if let navController = navigationController {
            navController.navigationBar.setTitleVerticalPositionAdjustment(space, for: UIBarMetrics.default)
        }
    }
    
    @objc func backButtonTapped() {
        _ = navigationController?.popViewController(animated: true)
    }
    
    static func initFromStoryboard(named storyboardName: StoryboardName) -> Self {
        return initFromStoryboardHelper(storyboardName: storyboardName.rawValue)
    }
    
    private class func initFromStoryboardHelper<T>(storyboardName: String) -> T {
        let storyoard = UIStoryboard(name: storyboardName, bundle: nil)
        let className = String(describing: self)
        let viewController = storyoard.instantiateViewController(withIdentifier: className) as! T
        return viewController
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
}
