//
//  ProductOffersView.swift
//  eCommerceDemo
//
//  Created by Hasan Ali Asan on 24.11.2023.
//  Copyright © 2023 Hasan Ali Asan. All rights reserved.
//

import UIKit

class ProductOffersView: UIView {
    // MARK: - Private Properties -
    
    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
    private var productOffersResponseModel: ProductOffersResponseModel?
    
    //
    
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
    }
    
    private func getOffers() {
        HNetworkManager.shared.sendRequest(with: ProductEndpoint.getProductRecommendations)
        { [weak self] (result: HNetworkResult<ProductOffersResponseModel>) in
            switch result {
            case .success(let productOffersResponseModel):
                self?.productOffersResponseModel = productOffersResponseModel
                
                self?.addOfferSections()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func addOfferSections() {
        DispatchQueue.main.async {
            for view in self.containerStackView.arrangedSubviews {
                self.containerStackView.removeArrangedSubview(view)
                view.removeFromSuperview()
            }
            
            if let content = self.productOffersResponseModel?.content {
                for item in content {
                    let sectionView = ProductOfferSectionView(offerItem: item)
                    self.containerStackView.addArrangedSubview(sectionView)
                }
            }
        }
    }
}

extension ProductOffersView: ViewLifeCycleProtocol {
    func viewDidLoad() {
        self.getOffers()
    }
    
    func reload() {
        self.getOffers()
    }
}
