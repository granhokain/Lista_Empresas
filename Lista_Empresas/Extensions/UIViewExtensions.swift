//
//  UIViewExtensions.swift
//  Lista_Empresas
//
//  Created by Rafael Martins on 14/01/20.
//  Copyright © 2020 Rafael Martins. All rights reserved.
//

import UIKit

extension UIView {
    @IBInspectable public var card: Bool {
        get {
            return self.card
        }
        set {
            self.layer.cornerRadius = 12.0
            self.layer.borderWidth = 0.5
            self.layer.borderColor = UIColor.clear.cgColor
            self.layer.masksToBounds = true
            self.layer.shadowColor = Colors.shadow.cgColor
            self.layer.shadowOffset = CGSize(width: 0, height: 2.0)
            self.layer.shadowRadius = 2.0
            self.layer.shadowOpacity = 1.0
            self.layer.masksToBounds = false
            self.layer.shadowPath = UIBezierPath(roundedRect:self.bounds, cornerRadius:self.layer.cornerRadius).cgPath
        }
        
    }
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        if #available(iOS 11.0, *) {
            clipsToBounds = true
            layer.cornerRadius = radius
            layer.maskedCorners = CACornerMask(rawValue: corners.rawValue)
        } else {
            let maskLayer = CAShapeLayer()
            maskLayer.path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners,
                                          cornerRadii: CGSize(width: radius, height: radius)).cgPath
            self.layer.mask = maskLayer
            layer.masksToBounds = true
        }
    }
    
    /// ViewExtension: Width of view.
    public var width: CGFloat {
        get {
            return frame.size.width
        }
        set {
            frame.size.width = newValue
        }
    }
    
    /// ViewExtension: Height of view.
    public var height: CGFloat {
        get {
            return frame.size.height
        }
        set {
            frame.size.height = newValue
        }
    }
    
    /// ViewExtension: x origin of view.
    public var x: CGFloat {
        get {
            return frame.origin.x
        }
        set {
            frame.origin.x = newValue
        }
    }
    
    /// ViewExtension: y origin of view.
    public var y: CGFloat {
        get {
            return frame.origin.y
        }
        set {
            frame.origin.y = newValue
        }
    }
    
    @IBInspectable var corneRadius: CGFloat {
        get {
            return self.corneRadius
        } set {
            layer.cornerRadius = newValue
            clipsToBounds = true
        }
    }
    
    @IBInspectable var setClipsToBounds: Bool {
        get {
            return self.setClipsToBounds
        } set {
            self.clipsToBounds = newValue
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return self.borderWidth
        } set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor {
        get {
            return self.borderColor
        } set {
            layer.borderColor = newValue.cgColor
        }
    }
    
    @IBInspectable var rounded: Bool {
        get {
            return self.rounded
        } set {
            self.corneRadius = newValue ? frame.size.height / 2 : 0
        }
    }
    
}

