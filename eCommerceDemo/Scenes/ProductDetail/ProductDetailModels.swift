//
//  ProductDetailModels.swift
//  eCommerceDemo
//
//  Created by Hasan Ali Asan on 25.11.2023.
//  Copyright (c) 2023 Hasan Ali Asan. All rights reserved.
//

import Foundation

typealias ProductDetailSections = [ProductDetail.Detail.ViewModel.Item]

enum ProductDetail {
    // MARK: - Use cases -
    
    enum Detail {
        struct Request {
            
        }
        
        struct Response {
            let responseModel: ProductDetailResponseModel?
        }
        
        struct ViewModel {
            enum OptionItemType {
                case detail
                case nutritions
            }
            
            enum Item {
                case imageItem(data: [URL?])
                case infoItem(model: ProductInfoCellViewModel)
                case optionItem(title: String?, optionType: OptionItemType)
            }
            
            let data: [[Item]]
        }
    }
}
