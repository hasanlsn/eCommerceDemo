//
//  ProductDetailPresenter.swift
//  eCommerceDemo
//
//  Created by Hasan Ali Asan on 25.11.2023.
//  Copyright (c) 2023 Hasan Ali Asan. All rights reserved.
//

import Foundation

protocol ProductDetailPresentationLogic: AnyObject {
    func presentProductDetail(response: ProductDetail.Detail.Response)
}

final class ProductDetailPresenter {
    weak var viewController: ProductDetailDisplayLogic?
}

// MARK: - ProductDetailPresentationLogic -

extension ProductDetailPresenter: ProductDetailPresentationLogic {
    func presentProductDetail(response: ProductDetail.Detail.Response) {
        var sections: [ProductDetailSections] = []
        
        var infoSectionItems: [ProductDetail.Detail.ViewModel.Item] = []
        
        // product images
        let product = response.responseModel?.product
        let images = product?.images?.map {
            return $0.url
        } ?? []
        
        infoSectionItems.append(.imageItem(data: images))
        //
        
        // product info
        let priceInfo = response.responseModel?.prices
        
        var originalPrice: String?
        if let price = priceInfo?.original?.text, price.isEmpty == false,
           let symbol = priceInfo?.original?.symbol {
            originalPrice = "\(price)\(symbol)"
        }
        
        var discountedPrice: String?
        if let price = priceInfo?.discounted?.text, price.isEmpty == false,
           let symbol = priceInfo?.discounted?.symbol {
            discountedPrice = "\(price)\(symbol)"
        }
        
        let infoViewModel = ProductInfoCellViewModel(name: product?.name,
                                                     description: product?.description,
                                                     brand: product?.brand?.name,
                                                     originalPrice: originalPrice,
                                                     discountedPrice: discountedPrice)
        infoSectionItems.append(.infoItem(model: infoViewModel))
        //
        
        var optionsSectionItems: [ProductDetail.Detail.ViewModel.Item] = []
        
        // options
        optionsSectionItems.append(.optionItem(title: "Ürün Bilgileri", optionType: .info))
        optionsSectionItems.append(.optionItem(title: "Besin Değerleri", optionType: .nutritions))
        //
        
        sections.append(infoSectionItems)
        sections.append(optionsSectionItems)
        
        let viewModel = ProductDetail.Detail.ViewModel(data: sections)
        self.viewController?.displayProductDetail(viewModel: viewModel)
    }
}

//
