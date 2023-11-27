//
//  ProductDetailInteractor.swift
//  eCommerceDemo
//
//  Created by Hasan Ali Asan on 25.11.2023.
//  Copyright (c) 2023 Hasan Ali Asan. All rights reserved.
//

import Foundation

protocol ProductDetailBusinessLogic: AnyObject { 
    func viewDidLoad()
}

protocol ProductDetailDataStore: AnyObject {
    var productDetailResponseModel: ProductDetailResponseModel? { get set }
}

final class ProductDetailInteractor {
    var presenter: ProductDetailPresentationLogic?
    private lazy var worker: ProductDetailWorkProtocol = ProductDetailWorker()
    
    var productDetailResponseModel: ProductDetailResponseModel?
}

// MARK: - ProductDetailBusinessLogic -

extension ProductDetailInteractor: ProductDetailBusinessLogic, ProductDetailDataStore { 
    func viewDidLoad() {
        self.getProductDetail(productId: "")
    }
}

//

extension ProductDetailInteractor {
    private func getProductDetail(productId: String) {
        HIndicator.show()
        self.worker.getProductDetail(productId: productId)
        { [weak self] result in
            HIndicator.hide()
            
            switch result {
            case .success(let productDetailResponseModel):
                self?.productDetailResponseModel = productDetailResponseModel
                
                let response = ProductDetail.Detail.Response(responseModel: productDetailResponseModel)
                self?.presenter?.presentProductDetail(response: response)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
