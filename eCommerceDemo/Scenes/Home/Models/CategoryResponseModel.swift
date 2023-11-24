//
//  CategoriesResponseModel.swift
//  eCommerceDemo
//
//  Created by Hasan Ali Asan on 23.11.2023.
//

import Foundation

struct CategoriesResponseModel: Decodable {
    let content: [CategoryItemModel]?
}

struct CategoryItemModel: Decodable {
    let title: String?
    let url: String?
    let images: [ImageItemModel]?
}

struct ImageItemModel: Decodable {
    let url: URL?
}
