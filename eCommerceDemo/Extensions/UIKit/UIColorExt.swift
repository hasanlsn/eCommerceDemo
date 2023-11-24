//
//  UIFontExt.swift
//  eCommerceDemo
//
//  Created by Hasan Ali Asan on 23.11.2023.
//  Copyright © 2023 Hasan Ali Asan. All rights reserved.
//

import UIKit

extension UIColor {
    static let davysGrey = UIColor(named: "DavysGrey")!
    static let darkCharcoal = UIColor(named: "DarkCharcoal")!
    static let minionYellow = UIColor(named: "MinionYellow")!
    static let usafaBlue = UIColor(named: "USAFABlue")!
    static let venetianRed = UIColor(named: "VenetianRed")!
    
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
