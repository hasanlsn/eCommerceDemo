//
//  HNetworkError.swift
//  eCommerceDemo
//
//  Created by Hasan Ali Asan on 23.11.2023.
//

import Foundation

enum HNetworkError: Error {
    case failed
    case decodingFailed
    case custom(message: String?)
}

extension HNetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .decodingFailed, .failed:
            return "Bir şeyler ters gitti!"
        case .custom(let error):
            return error
        }
    }
}
