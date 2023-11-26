//
//  ProductNutritionsInteractor.swift
//  eCommerceDemo
//
//  Created by Hasan Ali Asan on 26.11.2023.
//  Copyright (c) 2023 Hasan Ali Asan. All rights reserved.
//

import Foundation

protocol ProductNutritionsBusinessLogic: AnyObject { 
    func viewDidLoad()
}

protocol ProductNutritionsDataStore: AnyObject {
    var productDetailResponseModel: ProductDetailResponseModel? { get set }
}

final class ProductNutritionsInteractor {
    var presenter: ProductNutritionsPresentationLogic?
    var worker: ProductNutritionsWorker?
    
    var productDetailResponseModel: ProductDetailResponseModel?
}

// MARK: - ProductNutritionsBusinessLogic -

extension ProductNutritionsInteractor: ProductNutritionsBusinessLogic, ProductNutritionsDataStore { 
    func viewDidLoad() {
        let response = ProductNutritions.List.Response(responseModel: self.productDetailResponseModel)
        self.presenter?.presentNutritions(response: response)
    }
}

//
