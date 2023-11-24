//
//  ProductDetailResponseModel.swift
//  eCommerceDemo
//
//  Created by Hasan Ali Asan on 23.11.2023.
//

import Foundation

struct ProductDetailResponseModel: Decodable {
    let product: ProductModel?
    let prices: ProductPriceModel?
}
