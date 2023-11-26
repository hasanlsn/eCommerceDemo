//
//  ProductInfoPresenter.swift
//  eCommerceDemo
//
//  Created by Hasan Ali Asan on 25.11.2023.
//  Copyright (c) 2023 Hasan Ali Asan. All rights reserved.
//

import Foundation

protocol ProductInfoPresentationLogic: AnyObject {
    func presentProductInfo(response: ProductInfo.Info.Response)
}

final class ProductInfoPresenter {
    weak var viewController: ProductInfoDisplayLogic?
}

// MARK: - ProductInfoPresentationLogic -

extension ProductInfoPresenter: ProductInfoPresentationLogic {
    func presentProductInfo(response: ProductInfo.Info.Response) {
        let product = response.responseModel?.product
        let viewModel = ProductInfo.Info.ViewModel(htmlContent: product?.htmlContent ?? "",
                                                   productCode: product?.id ?? "",
                                                   brand: product?.brand?.name ?? "",
                                                   origin: product?.origin ?? "")
        self.viewController?.displayProductInfo(viewModel: viewModel)
    }
}

//
