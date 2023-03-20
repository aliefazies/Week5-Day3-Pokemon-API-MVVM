//
//  UIViewExtension.swift
//  Week5-Day3-Pokemon API MVVM
//
//  Created by Alief Ahmad Azies on 20/03/23.
//

import Foundation
import UIKit

extension UIView {
    
    func addTopShadow(shadowHeight height: CGFloat = 5) {
        let shadowPath = UIBezierPath()
        shadowPath.move(to: CGPoint(x: 0, y: 0))
        shadowPath.addLine(to: CGPoint(x: bounds.width, y:0))
        shadowPath.addLine(to: CGPoint(x: bounds.width-20, y: bounds.height ))
        shadowPath.addLine(to: CGPoint(x: bounds.width-20, y: bounds.height))
        shadowPath.close()
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.3
        layer.masksToBounds = false
        layer.shadowPath = shadowPath.cgPath
        layer.shadowRadius = 16
    }
    
    func setGradientBackground() {
        let colorTop = UIColor(rgb: 0x83ED6E).cgColor
        let colorBottom = UIColor(rgb: 0xf0f0f0).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = bounds
        
        layer.insertSublayer(gradientLayer, at:0)
        layer.cornerRadius = 12
        layer.masksToBounds = true
    }
    
}
