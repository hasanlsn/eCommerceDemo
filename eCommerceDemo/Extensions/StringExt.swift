//
//  StringExt.swift
//  eCommerceDemo
//
//  Created by Hasan Ali Asan on 24.11.2023.
//  Copyright © 2023 Hasan Ali Asan. All rights reserved.
//

import Foundation

extension Optional where Wrapped == String {
    var nilOrIsEmpty: Bool {
        guard let strongSelf = self else { return true }
        return strongSelf.isEmpty
    }
}
