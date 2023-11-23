//
//  CategoryEndpoint.swift
//  eCommerceDemo
//
//  Created by Hasan Ali Asan on 23.11.2023.
//

import Foundation

enum CategoryEndpoint {
    case getCategories
}

extension CategoryEndpoint: HEndpointType {
    var path: String{
        switch self {
        case .getCategories:
            return "/categories"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self{
        case .getCategories:
            return .get
        }
    }
}
