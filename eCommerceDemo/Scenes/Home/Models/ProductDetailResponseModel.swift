//
//  ProductDetailResponseModel.swift
//  eCommerceDemo
//
//  Created by Hasan Ali Asan on 23.11.2023.
//

import Foundation

struct ProductDetailResponseModel: Codable {
    let product: ProductModel?
    let prices: ProductPriceModel?
}
