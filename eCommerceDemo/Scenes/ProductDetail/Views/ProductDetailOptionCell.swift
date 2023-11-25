//
//  ProductDetailOptionCell.swift
//  eCommerceDemo
//
//  Created by Hasan Ali Asan on 25.11.2023.
//  Copyright © 2023 Hasan Ali Asan. All rights reserved.
//

import UIKit

class ProductDetailOptionCell: BaseTableViewCell {
    // MARK: - Private Properties -
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(.jostBold, size: 16)
        label.textColor = UIColor.color0551A0
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var rightArrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .clear
        imageView.clipsToBounds = true
        imageView.image = UIImage(systemName: "chevron.forward")
        imageView.tintColor = UIColor.color0551A0
        return imageView
    }()
    
    //
    
    func configure(title: String?) {
        self.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.rightArrowImageView)
        
        self.titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.top.equalToSuperview().offset(12)
            $0.bottom.equalToSuperview().offset(-12)
        }
        
        self.rightArrowImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-28)
            $0.leading.equalTo(self.titleLabel.snp.trailing)
            $0.centerY.equalTo(self.titleLabel.snp.centerY)
            $0.width.height.equalTo(14)
        }
        
        self.titleLabel.text = title
    }
}
