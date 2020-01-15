//
//  LottieHUD.swift
//  Lista_Empresas
//
//  Created by Rafael Martins on 14/01/20.
//  Copyright © 2020 Rafael Martins. All rights reserved.
//

import UIKit
import Lottie

public enum BackgroundType {
    case black30
    case clear
    case lightBlur
    case extraLightBlur
    case darkBlur
    case prominentBlur
}

public final class LottieHUD {
    
    private var backgroundView: UIView = {
        let bg = UIView()
        bg.translatesAutoresizingMaskIntoConstraints = false
        bg.isUserInteractionEnabled = false
        bg.alpha = 0.0
        
        return bg
    }()
    
    private var blurView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .light)
        let bgBlur = UIVisualEffectView(effect: blurEffect)
        bgBlur.translatesAutoresizingMaskIntoConstraints = false
        bgBlur.isUserInteractionEnabled = false
        bgBlur.alpha = 0.0
        
        return bgBlur
    }()
    
    private var hudView: UIView = {
        let hudView = UIView()
        hudView.translatesAutoresizingMaskIntoConstraints = false
        hudView.isUserInteractionEnabled = false
        hudView.backgroundColor = .white
        hudView.layer.shadowColor = UIColor.lightGray.cgColor
        hudView.layer.shadowOpacity = 1.5
        hudView.layer.shadowOffset = CGSize.zero
        hudView.layer.shadowRadius = 10
        hudView.layer.cornerRadius = 12
        
        return hudView
    }()
    
    private var _lottie: AnimationView!
    private var maskType: BackgroundType!
    private var size: CGSize!
    private var blurEffect: UIBlurEffect!
    private var animationDuration: TimeInterval = 0.3
    
    public var animationSpeed: CGFloat = 1.0
    public var contentMode: UIView.ContentMode = .scaleAspectFit {
        didSet {
            self._lottie.contentMode = contentMode
        }
    }
    
    init(_ name: String, loop: Bool = true, size: CGSize = CGSize(width: 70, height: 70), mask: BackgroundType) {
        self.size = size
        self.maskType = mask
        self._lottie = AnimationView(name: name)
        self._lottie.loopMode = .loop
    }
    
    init(_ lottie: AnimationView) {
        self._lottie = lottie
    }
    
    public func show(with delay: TimeInterval = 0.0, loop: Bool = true) {
        _lottie.animationSpeed = animationSpeed
        _lottie.loopMode = .loop
        createHUD(delay: delay)
    }
    
    public func hide() {
        clearHUD()
    }
    
    private func createHUD(delay: TimeInterval = 0.0) {
        DispatchQueue.main.async {
            UIApplication.shared.keyWindow!.isUserInteractionEnabled = false
            self.configureBgView()
            self.configureConstraints()
            UIView.animate(withDuration: self.animationDuration, delay: delay, options: .curveEaseIn, animations: {
                self.backgroundView.alpha = 1.0
                self.blurView.alpha = 1.0
            }, completion: nil)
            
            self._lottie.play(completion: { _ in
                self.clearHUD()
            })
        }
    }
    
    fileprivate func setupEffectBlur() {
        if maskType == .lightBlur {
            blurEffect = UIBlurEffect(style: .light)
        } else if maskType == .extraLightBlur {
            blurEffect = UIBlurEffect(style: .extraLight)
        } else if maskType == .darkBlur {
            blurEffect = UIBlurEffect(style: .dark)
        } else if maskType == .prominentBlur {
            if #available(iOS 10.0, *) {
                blurEffect = UIBlurEffect(style: .prominent)
            } else {
                blurEffect = UIBlurEffect(style: .light)
            }
        }
    }
    
    private func configureBgView() {
        if maskType == .black30 {
            backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        } else if maskType == .clear {
            backgroundView.backgroundColor = UIColor.clear
        } else {
            setupEffectBlur()
            self.blurView.effect = blurEffect
        }
    }
    
    fileprivate func setupBackgroundConstraints(_ keyWindowMargins: UIView) {
        backgroundView.leadingAnchor.constraint(equalTo: keyWindowMargins.leadingAnchor, constant: 0).isActive = true
        backgroundView.trailingAnchor.constraint(equalTo: keyWindowMargins.trailingAnchor, constant: 0).isActive = true
        backgroundView.topAnchor.constraint(equalTo: keyWindowMargins.topAnchor).isActive = true
        backgroundView.bottomAnchor.constraint(equalTo: keyWindowMargins.bottomAnchor).isActive = true
        
    }
    
    fileprivate func setupBlurViewConstraints(_ keyWindowMargins: UIView) {
        blurView.frame = keyWindowMargins.bounds
        blurView.leadingAnchor.constraint(equalTo: keyWindowMargins.leadingAnchor, constant: 0).isActive = true
        blurView.trailingAnchor.constraint(equalTo: keyWindowMargins.trailingAnchor, constant: 0).isActive = true
        blurView.topAnchor.constraint(equalTo: keyWindowMargins.topAnchor).isActive = true
        blurView.bottomAnchor.constraint(equalTo: keyWindowMargins.bottomAnchor).isActive = true
    }
    
    fileprivate func setupHUDViewContraints() {
        if isBlur {
            blurView.contentView.addSubview(hudView)
            hudView.centerXAnchor.constraint(equalTo: blurView.centerXAnchor, constant: 0).isActive = true
            hudView.centerYAnchor.constraint(equalTo: blurView.centerYAnchor, constant: 0).isActive = true
        } else {
            backgroundView.addSubview(hudView)
            hudView.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor, constant: 0).isActive = true
            hudView.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor, constant: 0).isActive = true
        }
        
        hudView.heightAnchor.constraint(equalToConstant: size.height).isActive = true
        hudView.widthAnchor.constraint(equalToConstant: size.width).isActive = true
        hudView.addSubview(_lottie)
    }
    
    fileprivate func configureLottieConstraints() {
        // Configure Lottie Constraints
        _lottie.translatesAutoresizingMaskIntoConstraints = false
        _lottie.centerXAnchor.constraint(equalTo: hudView.centerXAnchor, constant: 0).isActive = true
        _lottie.centerYAnchor.constraint(equalTo: hudView.centerYAnchor, constant: 0).isActive = true
        _lottie.heightAnchor.constraint(equalToConstant: size.height).isActive = true
        _lottie.widthAnchor.constraint(equalToConstant: size.width).isActive = true
    }
    
    private func configureConstraints() {
        
        if isBlur {
            self.keyWindow.view.addSubview(self.blurView)
            guard let keyWindowMargins = keyWindow.view else {return}
            setupBlurViewConstraints(keyWindowMargins)
        } else {
            self.keyWindow.view.addSubview(self.backgroundView)
            guard let keyWindowMargins = keyWindow.view else {return}
            setupBackgroundConstraints(keyWindowMargins)
        }
        
        setupHUDViewContraints()
        configureLottieConstraints()
    }
    
    private func clearHUD() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: self.animationDuration, delay: 0, options: .curveEaseIn, animations: {
                self.backgroundView.alpha = 0.0
                self.blurView.alpha = 0.0
            }) { finished in
                UIApplication.shared.keyWindow!.isUserInteractionEnabled = true
                if self.isBlur {
                    self.blurView.removeFromSuperview()
                } else {
                    self.backgroundView.removeFromSuperview()
                }
                self._lottie.stop()
            }
        }
    }
    
    private var keyWindow: UIViewController {
        return UIApplication.topViewController()!
    }
    
    private var isBlur: Bool {
        return !(maskType == .clear || maskType == .black30)
    }
    
}

extension UIApplication {
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}
