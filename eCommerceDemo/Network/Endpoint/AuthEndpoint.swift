//
//  AuthEndpoint.swift
//  eCommerceDemo
//
//  Created by Hasan Ali Asan on 23.11.2023.
//

import Foundation

enum AuthEndpoint {
    case login
}

extension AuthEndpoint: HEndpointType {
    var path: String{
        switch self {
        case .login:
            return "/login"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self{
        case .login:
            return .get
        }
    }
}
