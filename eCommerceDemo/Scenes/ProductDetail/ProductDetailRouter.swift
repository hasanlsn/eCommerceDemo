//
//  ProductDetailRouter.swift
//  eCommerceDemo
//
//  Created by Hasan Ali Asan on 25.11.2023.
//  Copyright (c) 2023 Hasan Ali Asan. All rights reserved.
//

import UIKit

enum ProductDetailNavigationOption {
    case info
    case nutritions
}

protocol ProductDetailRoutingLogic { 
    func navigate(to option: ProductDetailNavigationOption)
}

protocol ProductDetailDataPassing: AnyObject {
    var dataStore: ProductDetailDataStore? { get }
}

final class ProductDetailRouter: NSObject, ProductDetailDataPassing {
    weak var viewController: ProductDetailViewController?
    var dataStore: ProductDetailDataStore?
}

// MARK: - ProductDetailRoutingLogic -

extension ProductDetailRouter: ProductDetailRoutingLogic {
    func navigate(to option: ProductDetailNavigationOption) {
        switch option {
        case .info:
            let destinationVC = ProductInfoViewController()
            let destinationDS = destinationVC.router?.dataStore
            destinationDS?.productDetailResponseModel = self.dataStore?.productDetailResponseModel
            self.viewController?.presentPanModal(destinationVC)
        case .nutritions:
            let destinationVC = ProductNutritionsViewController()
            let destinationDS = destinationVC.router?.dataStore
            destinationDS?.productDetailResponseModel = self.dataStore?.productDetailResponseModel
            self.viewController?.presentPanModal(destinationVC)
        }
    }
}

//
