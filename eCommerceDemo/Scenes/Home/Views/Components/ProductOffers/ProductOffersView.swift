//
//  ProductOffersView.swift
//  eCommerceDemo
//
//  Created by Hasan Ali Asan on 24.11.2023.
//  Copyright © 2023 Hasan Ali Asan. All rights reserved.
//

import UIKit

class ProductOffersView: UIView {
    
    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
    private var productOffersResponseModel: ProductOffersResponseModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.commonInit()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        self.addSubview(self.containerStackView)
        
        self.containerStackView.snp.makeConstraints {
            $0.trailing.leading.top.bottom.equalToSuperview()
        }
        
        self.getOffers()
    }
    
    private func getOffers() {
        HNetworkManager.shared.sendRequest(with: ProductEndpoint.getProductRecommendations)
        { [weak self] (result: HNetworkResult<ProductOffersResponseModel>) in
            switch result {
            case .success(let productOffersResponseModel):
                self?.productOffersResponseModel = productOffersResponseModel
                
                if let content = productOffersResponseModel.content {
                    for item in content {
                        let sectionView = ProductOfferSectionView(offerItem: item)
                        self?.containerStackView.addArrangedSubview(sectionView)
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
