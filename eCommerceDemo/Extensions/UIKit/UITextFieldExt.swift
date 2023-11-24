//
//  UITextFieldExt.swift
//  eCommerceDemo
//
//  Created by Hasan Ali Asan on 25.11.2023.
//  Copyright © 2023 Hasan Ali Asan. All rights reserved.
//

import UIKit

extension UITextField {
    func newString(range: NSRange, replacementString string: String) -> String {
        if let text = self.text as NSString? {
            return text.replacingCharacters(in: range, with: string)
        }
        
        return ""
    }
}
