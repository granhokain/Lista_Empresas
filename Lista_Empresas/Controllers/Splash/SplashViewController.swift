//
//  SplashViewController.swift
//  Lista_Empresas
//
//  Created by Rafael Martins on 21/01/20.
//  Copyright © 2020 Rafael Martins. All rights reserved.
//

import UIKit
//import Lottie

protocol SplashViewControllerDelegate: class {
    func showHome()
    func showLogin()
}

class SplashViewController: BaseViewController, SplashStoryboardLodable {

    @IBOutlet weak var splashLoading: UIActivityIndicatorView!
    
    // MARK: - Members
    weak var delegate: SplashViewControllerDelegate?
    var splashPresenter: SplashPresentable?
    var timer: Timer!

    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showAnimation()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.hiddenNavigationController(true, animated: false)
    }
    
    private func showAnimation() {
        splashLoading.startAnimating()
        timer = Timer.scheduledTimer(timeInterval: 3.5, target: self, selector: #selector(animationCompleted), userInfo: nil, repeats: false)
    }
    
    @objc func animationCompleted() {
        splashLoading.stopAnimating()
        self.splashPresenter?.verifySession()
    }
}

extension SplashViewController: SplashViewable {
    func showHomeView() {
        self.delegate?.showHome()
    }
    
    func showLoginView() {
        self.delegate?.showLogin()
    }
}
