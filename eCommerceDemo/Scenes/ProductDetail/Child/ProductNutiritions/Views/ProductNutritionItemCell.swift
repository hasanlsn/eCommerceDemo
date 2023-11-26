//
//  ProductNutritionItemCell.swift
//  eCommerceDemo
//
//  Created by Hasan Ali Asan on 26.11.2023.
//  Copyright © 2023 Hasan Ali Asan. All rights reserved.
//

import UIKit

protocol ProductNutritionItemCellProtocol {
    var title: String? { get }
    var value: String? { get }
}

class ProductNutritionItemCell: BaseTableViewCell {
    // MARK: - Private Properties -
    
    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, valueLabel])
        stackView.spacing = 4
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(.jostBold, size: 12)
        label.textColor = UIColor.color333333
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(.jostRegular, size: 12)
        label.textColor = UIColor.color333333
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.colorF2F2F2
        return view
    }()
    
    //
    
    func configure(viewModel: ProductNutritionItemCellProtocol) {
        self.contentView.addSubview(self.dividerView)
        self.contentView.addSubview(self.containerStackView)
        
        self.containerStackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(24)
            $0.bottom.equalToSuperview().offset(-16)
            $0.trailing.equalToSuperview().offset(-15)
        }
        
        self.dividerView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        self.titleLabel.text = viewModel.title
        self.valueLabel.text = viewModel.value
    }
}
