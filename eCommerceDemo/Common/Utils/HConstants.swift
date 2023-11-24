//
//  HConstants.swift
//  eCommerceDemo
//
//  Created by Hasan Ali Asan on 23.11.2023.
//

import Foundation
import AnyFormatKit

struct HConstants {
    static let API_HOST_DEV = "demo5416316.mockable.io"
    static let API_URL_DEV = "https:\(HConstants.API_HOST_DEV)"
    
    struct Keychain {
        static var USER_PROFILE_INFO = "USER_PROFILE_INFO_KEY"
    }
    
    struct TextFormatter {
        static let TURKEY_PHONE_NUMBER_FORMATTER = DefaultTextInputFormatter(textPattern: "### ### ## ##")
    }
}
