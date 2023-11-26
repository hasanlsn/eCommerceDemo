//
//  ProductInfoModels.swift
//  eCommerceDemo
//
//  Created by Hasan Ali Asan on 25.11.2023.
//  Copyright (c) 2023 Hasan Ali Asan. All rights reserved.
//

import Foundation

enum ProductInfo {
    // MARK: - Use cases -
    
    enum Info {
        struct Request {
            
        }
        
        struct Response {
            let responseModel: ProductDetailResponseModel?
        }
        
        struct ViewModel {
            let htmlContent: String
            let productCode: String
            let brand: String
            let origin: String
        }
    }
}
