//
//  BrandBannersResponseModel.swift
//  eCommerceDemo
//
//  Created by Hasan Ali Asan on 23.11.2023.
//

import Foundation

struct BrandBannersResponseModel: Decodable {
    let content: [BrandBannerItemModel]?
}

struct BrandBannerItemModel: Decodable {
    let title: String?
    let description: String?
    let url: String?
    let buttonText: String?
    let textColor: String?
    let backgroundColor: String?
    let images: [ImageItemModel]?
}
