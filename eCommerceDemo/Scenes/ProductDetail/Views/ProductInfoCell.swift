//
//  ProductInfoCell.swift
//  eCommerceDemo
//
//  Created by Hasan Ali Asan on 25.11.2023.
//  Copyright © 2023 Hasan Ali Asan. All rights reserved.
//

import UIKit

struct ProductInfoCellViewModel {
    let name: String?
    let description: String?
    let brand: String?
    let originalPrice: String?
    let discountedPrice: String?
}

class ProductInfoCell: BaseTableViewCell {
    // MARK: - Private Properties -
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(.jostMedium, size: 16)
        label.textColor = UIColor.color333333
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var brandLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(.jostRegular, size: 13)
        label.textColor = UIColor.colorCCCCCC
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var descLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(.jostRegular, size: 13)
        label.textColor = UIColor.color555555
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var priceView: PriceView = {
        let view = PriceView()
        return view
    }()
    
    //
    
    func configure(viewModel: ProductInfoCellViewModel) {
        self.contentView.addSubview(self.nameLabel)
        self.contentView.addSubview(self.brandLabel)
        self.contentView.addSubview(self.descLabel)
        self.contentView.addSubview(self.priceView)
        
        self.nameLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.top.equalToSuperview().offset(16)
        }
        
        self.brandLabel.snp.makeConstraints {
            $0.leading.equalTo(self.nameLabel)
            $0.top.equalTo(self.nameLabel.snp.bottom).offset(4)
        }
        
        self.descLabel.snp.makeConstraints {
            $0.leading.equalTo(self.nameLabel)
            $0.trailing.equalToSuperview().offset(-16)
            $0.top.equalTo(self.brandLabel.snp.bottom).offset(16)
            $0.bottom.equalToSuperview().offset(-12)
        }
        
        self.brandLabel.snp.makeConstraints {
            $0.leading.equalTo(self.nameLabel)
            $0.top.equalTo(self.nameLabel.snp.bottom).offset(4)
        }
        
        self.priceView.snp.makeConstraints {
            $0.leading.greaterThanOrEqualTo(self.nameLabel.snp.trailing).offset(8).priority(.low)
            $0.leading.greaterThanOrEqualTo(self.brandLabel.snp.trailing).offset(8).priority(.low)
            $0.top.equalTo(self.nameLabel.snp.top)
            $0.trailing.equalToSuperview().offset(-16)
            $0.bottom.greaterThanOrEqualTo(self.descLabel.snp.top).offset(-16).priority(.low)
        }
        
        self.nameLabel.text = viewModel.name
        self.brandLabel.text = viewModel.brand
        self.descLabel.text = viewModel.description
        self.priceView.setPrice(originalPrice: viewModel.originalPrice,
                                discountedPrice: viewModel.discountedPrice)
    }
}
