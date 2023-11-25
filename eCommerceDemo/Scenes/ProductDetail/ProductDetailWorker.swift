//
//  ProductDetailWorker.swift
//  eCommerceDemo
//
//  Created by Hasan Ali Asan on 25.11.2023.
//  Copyright (c) 2023 Hasan Ali Asan. All rights reserved.
//

import Foundation

protocol ProductDetailWorkProtocol {
    func getProductDetail(productId: String, completion: RequestCompletionBlock<ProductDetailResponseModel>)
}

final class ProductDetailWorker: ProductDetailWorkProtocol {
    func getProductDetail(productId: String, completion: RequestCompletionBlock<ProductDetailResponseModel>) {
        HNetworkManager.shared.sendRequest(with: ProductEndpoint.getProductDetail, completion: completion)
    }
}
