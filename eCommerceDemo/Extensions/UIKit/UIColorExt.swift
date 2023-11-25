//
//  UIFontExt.swift
//  eCommerceDemo
//
//  Created by Hasan Ali Asan on 23.11.2023.
//  Copyright © 2023 Hasan Ali Asan. All rights reserved.
//

import UIKit

extension UIColor {
    static let color555555 = UIColor(named: "Color555555")!
    static let color333333 = UIColor(named: "Color333333")!
    static let colorFAE14B = UIColor(named: "ColorFAE14B")!
    static let color0551A0 = UIColor(named: "Color0551A0")!
    static let colorCC1512 = UIColor(named: "ColorCC1512")!
    static let colorB0B9C1 = UIColor(named: "ColorB0B9C1")!
    static let color777777 = UIColor(named: "Color777777")!
    static let colorCCCCCC = UIColor(named: "ColorCCCCCC")!
    static let colorFFE000 = UIColor(named: "ColorFFE000")!
    static let colorE5E5E5 = UIColor(named: "ColorE5E5E5")!
    
    static func colorFromHex(hex: String?, alpha: CGFloat = 1.0) -> UIColor? {
        guard let hex else {
            return nil
        }
             
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }

        if cString.count != 6 {
            return nil
        }

        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        let mask = 0x000000FF
        let r = Int(rgbValue >> 16) & mask
        let g = Int(rgbValue >> 8) & mask
        let b = Int(rgbValue) & mask
        
        let red = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue = CGFloat(b) / 255.0
        
        return UIColor(red:red, green: green, blue: blue, alpha: alpha)
    }
}
