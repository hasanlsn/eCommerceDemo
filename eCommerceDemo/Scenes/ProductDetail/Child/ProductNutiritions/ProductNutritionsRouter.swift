//
//  ProductNutritionsRouter.swift
//  eCommerceDemo
//
//  Created by Hasan Ali Asan on 26.11.2023.
//  Copyright (c) 2023 Hasan Ali Asan. All rights reserved.
//

import UIKit

enum ProductNutritionsNavigationOption { }

protocol ProductNutritionsRoutingLogic { 
    func navigate(to option: ProductNutritionsNavigationOption)
}

protocol ProductNutritionsDataPassing: AnyObject {
    var dataStore: ProductNutritionsDataStore? { get }
}

final class ProductNutritionsRouter: NSObject, ProductNutritionsDataPassing {
    weak var viewController: ProductNutritionsViewController?
    var dataStore: ProductNutritionsDataStore?
}

// MARK: - ProductNutritionsRoutingLogic -

extension ProductNutritionsRouter: ProductNutritionsRoutingLogic {
    func navigate(to option: ProductNutritionsNavigationOption) { }
}

//
