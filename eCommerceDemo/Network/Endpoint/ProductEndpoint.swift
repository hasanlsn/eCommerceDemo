//
//  ProductEndpoint.swift
//  eCommerceDemo
//
//  Created by Hasan Ali Asan on 23.11.2023.
//

import Foundation

enum ProductEndpoint {
    case getProductRecommendations
    case getProductDetail
}

extension ProductEndpoint: HEndpointType {
    var path: String{
        switch self {
        case .getProductRecommendations:
            return "/product-recommendations"
        case .getProductDetail:
            return "/product"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self{
        case .getProductRecommendations,
                .getProductDetail:
            return .get
        }
    }
}
