//
//  ProfileEndpoint.swift
//  eCommerceDemo
//
//  Created by Hasan Ali Asan on 23.11.2023.
//

import Foundation

enum ProfileEndpoint {
    case getMyWallet
}

extension ProfileEndpoint: HEndpointType {
    var path: String{
        switch self {
        case .getMyWallet:
            return "/my-wallet"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self{
        case .getMyWallet:
            return .get
        }
    }
}
