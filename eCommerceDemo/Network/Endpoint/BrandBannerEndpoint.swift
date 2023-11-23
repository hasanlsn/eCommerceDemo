//
//  BrandBannerEndpoint.swift
//  eCommerceDemo
//
//  Created by Hasan Ali Asan on 23.11.2023.
//

import Foundation

enum BrandBannerEndpoint {
    case getBrandBanners
}

extension BrandBannerEndpoint: HEndpointType {
    var path: String{
        switch self {
        case .getBrandBanners:
            return "/brand-banners"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self{
        case .getBrandBanners:
            return .get
        }
    }
}
