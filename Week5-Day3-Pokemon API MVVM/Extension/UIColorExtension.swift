//
//  UIColorExtension.swift
//  Week5-Day3-Pokemon API MVVM
//
//  Created by Alief Ahmad Azies on 16/03/23.
//

import Foundation
import UIKit

extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
    
    func setBackgroundLabel(type: String) -> UIColor {
        switch type {
        case "fire":
            return UIColor(rgb: 0xF57D31)
        case "grass":
            return UIColor(rgb: 0x74CB48)
        case "poison":
            return UIColor(rgb: 0xA43E9E)
        case "water":
            return UIColor(rgb: 0x6493EB)
        case "bug":
            return UIColor(rgb: 0xA7B723)
        case "flying":
            return UIColor(rgb: 0xA891EC)
        case "electric":
            return UIColor(rgb: 0xF9CF30)
        case "ghost":
            return UIColor(rgb: 0x70559B)
        case "normal":
            return UIColor(rgb: 0xAAA67F)
        case "psychic":
            return UIColor(rgb: 0xFB5584)
        case "steel":
            return UIColor(rgb: 0xB7B9D0)
        case "rock":
            return UIColor(rgb: 0xB69E31)
        default:
            return UIColor(rgb: 0x374151)
            
        }
    }
}
