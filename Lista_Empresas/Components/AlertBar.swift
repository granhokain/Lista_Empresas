//
//  AlertBar.swift
//  Lista_Empresas
//
//  Created by Rafael Martins on 14/01/20.
//  Copyright © 2020 Rafael Martins. All rights reserved.
//

import UIKit

class FDCAlertBar: UIView {
    
    private var alertView: UIView!
    private var detailLabel: UILabel!
    private var text: String!
    private var completionBlock: (() -> ())?
    private var time = 3
    var isShowing = false
    
    // style
    var textColor: UIColor = .white
    var bgColor: UIColor = Colors.primaryColor
    var font: UIFont = UIFont(name: "NexaSlab-Bold", size: 16.0)!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(text: String) {
        self.init(frame: UIScreen.main.bounds)
        self.text = text
        self.setup()
    }
    
    func setup() {
        self.height = 44
        setupAlertView()
        setupLabel()
    }
    
    private func setupAlertView() {
        let bounds = UIScreen.main.bounds
        alertView = UIView()
        addSubview(alertView)
        
        alertView.widthAnchor.constraint(equalToConstant: bounds.width).isActive = true
        alertView.heightAnchor.constraint(greaterThanOrEqualToConstant: 44).isActive = true
        alertView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        alertView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        alertView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        alertView.translatesAutoresizingMaskIntoConstraints = false
        
        alertView.backgroundColor = bgColor
    }
    
    private func setupLabel() {
        detailLabel = UILabel()
        detailLabel.numberOfLines = 0
        detailLabel.font = font
        alertView.addSubview(detailLabel)
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        detailLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 18).isActive = true
        detailLabel.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: 8.0).isActive = true
        detailLabel.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -8.0).isActive = true
        detailLabel.topAnchor.constraint(equalTo: alertView.topAnchor, constant: 8).isActive = true
        detailLabel.bottomAnchor.constraint(equalTo: alertView.bottomAnchor, constant: -8).isActive = true
        detailLabel.text = text
        detailLabel.textColor = textColor
        detailLabel.textAlignment = .center
    }
    
    @objc private func close() {
        self.completionBlock = nil
        self.dismiss(animated: true, completion: {})
    }
    
    func show(animated: Bool, time: Int? = nil, completion: @escaping() -> ()) {
        self.completionBlock = completion
        self.isShowing = true
        
        if animated {
            self.y = (-self.height * 2)
            checkVisibleNavigation()
            UIView.animate(withDuration: 0.7, delay: 0.2, options: .curveEaseOut, animations: {
                self.checkYPosition()
            }) { (completed) in
                self.addTimer(time)
            }
        } else {
            checkVisibleNavigation()
            self.checkYPosition()
            self.addTimer(time)
        }
    }
    
    private func dismiss(animated: Bool, completion: @escaping () -> ()) {
        if animated {
            UIView.animate(withDuration: 0.5, delay: 0.2, options: .curveEaseInOut, animations: {
                self.y =  (-self.height * 2)
            }) { (completed) in
                self.removeFromSuperview()
                self.isShowing = false
                guard let completion = self.completionBlock else { return }
                completion()
            }
        } else {
            self.removeFromSuperview()
            self.isShowing = false
            guard let completion = self.completionBlock else { return }
            completion()
        }
    }
    
    private func addTimer(_ time: Int?) {
        if let time = time {
            self.time = time
        }
        
        let deadlineTime = DispatchTime.now() + .seconds(self.time)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            self.dismiss(animated: true, completion: {})
        }
    }
    
    private func checkVisibleNavigation() {
        guard let topViewController = UIApplication.topViewController() else { return }
        
        if topViewController.navigationController != nil && topViewController.navigationController!.isNavigationBarHidden {
            topViewController.view.addSubview(self)
        } else {
            topViewController.navigationController?.navigationBar.addSubview(self)
        }
    }
    
    
    private func checkYPosition() {
        guard let topViewController = UIApplication.topViewController() else { return }
        
        if topViewController.navigationController != nil && topViewController.navigationController!.isNavigationBarHidden {
            self.y = 20
        } else {
            self.y = 0
        }
    }
}

