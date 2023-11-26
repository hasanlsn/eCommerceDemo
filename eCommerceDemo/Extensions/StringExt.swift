//
//  StringExt.swift
//  eCommerceDemo
//
//  Created by Hasan Ali Asan on 24.11.2023.
//  Copyright © 2023 Hasan Ali Asan. All rights reserved.
//

import UIKit

extension Optional where Wrapped == String {
    var nilOrIsEmpty: Bool {
        guard let strongSelf = self else { return true }
        return strongSelf.isEmpty
    }
}

extension String {
    func containsOnlyDigits() -> Bool {
        let regexNumbersOnly = try? NSRegularExpression(pattern: ".*[^0-9].*", options: [])
        return regexNumbersOnly?.firstMatch(in: self, options: [], range: NSMakeRange(0, self.count)) == nil
    }
    
    func toCleanText() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: " ", with: "")
    }
    
    func isValidPhone() -> Bool {
        let phoneRegex = "^5(?:[01345][0-9])(?:[0-9]{3})(?:[0-9]{2})(?:[0-9]{2})$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phoneTest.evaluate(with: self)
    }
}

extension NSMutableAttributedString {
    func bold(_ value: String,
              fontSize: CGFloat = 12,
              color: UIColor = .color555555) -> NSMutableAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(.jostBold, size: fontSize),
            .foregroundColor: color
        ]
        
        self.append(NSAttributedString(string: value, attributes: attributes))
        return self
    }
    
    func regular(_ value:String,
                 fontSize: CGFloat = 12,
                 color: UIColor = .color555555) -> NSMutableAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .font : UIFont(.jostRegular, size: fontSize),
            .foregroundColor: color
        ]
        
        self.append(NSAttributedString(string: value, attributes: attributes))
        return self
    }
}
