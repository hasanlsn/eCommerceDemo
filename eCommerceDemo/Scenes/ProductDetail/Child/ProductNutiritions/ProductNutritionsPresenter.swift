//
//  ProductNutritionsPresenter.swift
//  eCommerceDemo
//
//  Created by Hasan Ali Asan on 26.11.2023.
//  Copyright (c) 2023 Hasan Ali Asan. All rights reserved.
//

import Foundation

protocol ProductNutritionsPresentationLogic: AnyObject {
    func presentNutritions(response: ProductNutritions.List.Response)
}

final class ProductNutritionsPresenter {
    weak var viewController: ProductNutritionsDisplayLogic?
}

// MARK: - ProductNutritionsPresentationLogic -

extension ProductNutritionsPresenter: ProductNutritionsPresentationLogic {
    func presentNutritions(response: ProductNutritions.List.Response) {
        let data: [ProductNutritions.List.ViewModel.Item]
        = response.responseModel?.product?.nutritionFacts?.map { item in
            let value = item.value == nil ? "-" : "\(item.value!)"
            return ProductNutritions.List.ViewModel.Item(title: item.label,
                                                          value: value)
        } ?? []
        
        let viewModel = ProductNutritions.List.ViewModel(data: data)
        self.viewController?.displayNutritions(viewModel: viewModel)
    }
}

//
