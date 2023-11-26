//
//  ProductInfoRouter.swift
//  eCommerceDemo
//
//  Created by Hasan Ali Asan on 25.11.2023.
//  Copyright (c) 2023 Hasan Ali Asan. All rights reserved.
//

import UIKit

enum ProductInfoNavigationOption { }

protocol ProductInfoRoutingLogic { 
    func navigate(to option: ProductInfoNavigationOption)
}

protocol ProductInfoDataPassing: AnyObject {
    var dataStore: ProductInfoDataStore? { get }
}

final class ProductInfoRouter: NSObject, ProductInfoDataPassing {
    weak var viewController: ProductInfoViewController?
    var dataStore: ProductInfoDataStore?
}

// MARK: - ProductInfoRoutingLogic -

extension ProductInfoRouter: ProductInfoRoutingLogic {
    func navigate(to option: ProductInfoNavigationOption) { }
}

//
