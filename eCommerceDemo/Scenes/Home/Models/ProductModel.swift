//
//  ProductModel.swift
//  eCommerceDemo
//
//  Created by Hasan Ali Asan on 23.11.2023.
//

import Foundation

struct ProductModel: Codable {
    let id: String?
    let name: String?
    let description: String?
    let origin: String?
    let htmlContent: String?
    let brand: ProductBrandModel?
    let images: [ImageItemModel]?
    let nutritionFacts: [ProductNutritionFactItemModel]?
}

struct ProductPriceModel: Codable {
    let discounted: ProductPriceItemModel?
    let original: ProductPriceItemModel?
}

struct ProductPriceItemModel: Codable {
    let text: String?
    let value: Double?
    let currency: String?
    let symbol: String?
}

struct ProductBrandModel: Codable {
    let id: Int?
    let code: String?
    let name: String?
}

struct ProductNutritionFactItemModel: Codable {
    let label: String?
    let value: Int?
}
