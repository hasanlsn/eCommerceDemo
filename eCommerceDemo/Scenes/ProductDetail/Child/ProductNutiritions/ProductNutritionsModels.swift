//
//  ProductNutritionsModels.swift
//  eCommerceDemo
//
//  Created by Hasan Ali Asan on 26.11.2023.
//  Copyright (c) 2023 Hasan Ali Asan. All rights reserved.
//

import Foundation

enum ProductNutritions {
    // MARK: - Use cases -
    
    enum List {
        struct Request {
            
        }
        
        struct Response {
            let responseModel: ProductDetailResponseModel?
        }
        
        struct ViewModel {
            struct Item {
                let title: String?
                let value: String?
            }
            
            let data: [Item]
        }
    }
}

extension ProductNutritions.List.ViewModel.Item: ProductNutritionItemCellProtocol {
    // already conforms
}
