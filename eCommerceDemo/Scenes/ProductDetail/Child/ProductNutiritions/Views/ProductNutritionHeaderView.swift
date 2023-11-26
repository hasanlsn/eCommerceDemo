//
//  ProductNutritionHeaderView.swift
//  eCommerceDemo
//
//  Created by Hasan Ali Asan on 26.11.2023.
//  Copyright © 2023 Hasan Ali Asan. All rights reserved.
//

import UIKit

class ProductNutritionHeaderView: UITableViewHeaderFooterView {
    // MARK: - Private Properties -
    
    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, valueLabel])
        stackView.spacing = 4
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var roundedView: UIView = {
        let view = UIView()
        view.backgroundColor = .colorF2F2F2
        view.roundCorners(corners: [.topLeft, .topRight], radius: 4)
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(.jostBold, size: 13)
        label.textColor = UIColor.color333333
        label.text = "Porsiyon"
        return label
    }()
    
    private lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(.jostBold, size: 13)
        label.textColor = UIColor.color333333
        label.text = "100 g/ml"
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
        self.contentView.addSubview(self.roundedView)
        self.contentView.addSubview(self.containerStackView)
        
        self.roundedView.snp.makeConstraints {
            $0.trailing.leading.top.bottom.equalToSuperview()
        }
        
        self.containerStackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(24)
            $0.bottom.equalToSuperview().offset(-16)
            $0.trailing.equalToSuperview().offset(-15)
        }
    }
}
