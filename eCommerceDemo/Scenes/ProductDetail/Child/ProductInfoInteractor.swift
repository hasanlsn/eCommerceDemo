//
//  ProductInfoInteractor.swift
//  eCommerceDemo
//
//  Created by Hasan Ali Asan on 25.11.2023.
//  Copyright (c) 2023 Hasan Ali Asan. All rights reserved.
//

import Foundation

protocol ProductInfoBusinessLogic: AnyObject { 
    func viewDidLoad()
}

protocol ProductInfoDataStore: AnyObject {
    var productDetailResponseModel: ProductDetailResponseModel? { get set }
}

final class ProductInfoInteractor {
    var presenter: ProductInfoPresentationLogic?
    var worker: ProductInfoWorker?
    
    var productDetailResponseModel: ProductDetailResponseModel?
}

// MARK: - ProductInfoBusinessLogic -

extension ProductInfoInteractor: ProductInfoBusinessLogic, ProductInfoDataStore { 
    func viewDidLoad() {
        let response = ProductInfo.Info.Response(responseModel: self.productDetailResponseModel)
        self.presenter?.presentProductInfo(response: response)
    }
}

//
