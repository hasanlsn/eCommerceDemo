//
//  UIFontExt.swift
//  eCommerceDemo
//
//  Created by Hasan Ali Asan on 23.11.2023.
//  Copyright © 2023 Hasan Ali Asan. All rights reserved.
//

import UIKit

enum FontTypes: String {
    case jostRegular = "Jost-Regular"
    case jostBold = "Jost-Bold"
    case jostSemiBold = "Jost-SemiBold"
    case jostMedium = "Jost-Medium"
}

extension UIFont {
    convenience init(_ type: FontTypes, size: CGFloat = UIFont.systemFontSize) {
        self.init(name: type.rawValue, size: size)!
    }
}
