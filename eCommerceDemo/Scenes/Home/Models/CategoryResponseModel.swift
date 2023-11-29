//
//  CategoriesResponseModel.swift
//  eCommerceDemo
//
//  Created by Hasan Ali Asan on 23.11.2023.
//

import Foundation

struct CategoriesResponseModel: Codable {
    let content: [CategoryItemModel]?
}

struct CategoryItemModel: Codable {
    let title: String?
    let url: String?
    let images: [ImageItemModel]?
}

struct ImageItemModel: Codable {
    let url: URL?
}
