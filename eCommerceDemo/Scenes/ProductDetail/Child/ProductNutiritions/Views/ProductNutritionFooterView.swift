//
//  ProductNutritionFooterView.swift
//  eCommerceDemo
//
//  Created by Hasan Ali Asan on 26.11.2023.
//  Copyright © 2023 Hasan Ali Asan. All rights reserved.
//

import UIKit

class ProductNutritionFooterView: UITableViewHeaderFooterView {
    // MARK: - Private Properties -
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(.jostRegular, size: 12)
        label.textColor = UIColor.color555555
        label.numberOfLines = 0
        label.text = "Lorem ipsum dolor sit amet."
        return label
    }()
    
    //
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        self.commonInit()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        self.contentView.addSubview(self.titleLabel)
        
        self.titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-16)
        }
    }
}
