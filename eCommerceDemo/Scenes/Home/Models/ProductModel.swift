//
//  ProductModel.swift
//  eCommerceDemo
//
//  Created by Hasan Ali Asan on 23.11.2023.
//

import Foundation

struct ProductModel: Decodable {
    let id: Int?
    let name: String?
    let description: String?
    let origin: String?
    let htmlContent: String?
    let brand: ProductBrandModel?
    let images: [ImageItemModel]?
    let nutritionFacts: [ProductNutritionFactItemModel]?
}

struct ProductPriceModel: Decodable {
    let discounted: ProductPriceItemModel?
    let original: ProductPriceItemModel?
}

struct ProductPriceItemModel: Decodable {
    let text: String?
    let value: Double?
    let currency: String?
    let symbol: String?
}

struct ProductBrandModel: Decodable {
    let id: String?
    let code: String?
    let name: String?
}

struct ProductNutritionFactItemModel: Decodable {
    let label: String?
    let value: Int?
}
