//
//  ProductOffersResponseModel.swift
//  eCommerceDemo
//
//  Created by Hasan Ali Asan on 23.11.2023.
//

import Foundation

struct ProductOffersResponseModel: Codable {
    let content: [ProductOfferItemModel]?
}

struct ProductOfferItemModel: Codable {
    let title: String?
    let serviceType: String?
    let bannerTitleColor: String?
    let images: [ImageItemModel]?
    let skuOffers: [SkuOfferModel]?
}

struct SkuOfferModel: Codable {
    let id: String?
    let product: ProductModel?
    let prices: ProductPriceModel?
}
