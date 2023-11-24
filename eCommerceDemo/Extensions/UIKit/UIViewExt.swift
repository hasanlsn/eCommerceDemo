//
//  UIView.swift
//  eCommerceDemo
//
//  Created by Hasan Ali Asan on 23.11.2023.
//  Copyright © 2023 Hasan Ali Asan. All rights reserved.
//

import UIKit

extension UIView {
    func roundCorners(radius: CGFloat) {
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
    }
    
    func addShadowWithRoundedCorners(color: UIColor,
                                     corners: UIRectCorner,
                                     radius: CGFloat) {
        self.clipsToBounds = false
        self.layer.cornerRadius = radius
        
        let shadowOpacity: Float = 0.4
        let shadowSize: CGFloat = 4.0
        let visibleShadowSize: CGFloat = (CGFloat(shadowOpacity) * shadowSize)
        
        let shadowWidth: CGFloat = self.frame.size.width + shadowSize
        var shadowHeight: CGFloat = self.bounds.size.height + shadowSize
        
        let shadowX: CGFloat = -visibleShadowSize
        var shadowY: CGFloat = -visibleShadowSize
        
        var shadowPath: UIBezierPath!
        
        if !corners.contains(.bottomRight) {
            shadowHeight = self.bounds.size.height - shadowSize
        }else if !corners.contains(.topRight) {
            shadowY = radius
            shadowHeight = self.bounds.size.height - radius + visibleShadowSize
        }
        
        shadowPath = UIBezierPath(roundedRect: CGRect(x: shadowX,
                                                      y: shadowY,
                                                      width:shadowWidth,
                                                      height: shadowHeight),
                                  byRoundingCorners: corners,
                                  cornerRadii: CGSize(width: radius,
                                                      height: radius))
        
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOffset = .zero
        layer.shadowOpacity = shadowOpacity
        layer.shadowPath = shadowPath.cgPath
    }
    
    func addBorder(width: CGFloat, color: UIColor){
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
    }
}
