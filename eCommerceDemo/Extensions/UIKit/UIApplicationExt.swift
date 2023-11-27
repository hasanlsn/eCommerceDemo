//
//  UIApplicationExt.swift
//  eCommerceDemo
//
//  Created by Hasan Ali Asan on 27.11.2023.
//

import UIKit

extension UIApplication {
    static func resignAllResponders() {
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil,
            from: nil,
            for: nil
        )
    }
}
