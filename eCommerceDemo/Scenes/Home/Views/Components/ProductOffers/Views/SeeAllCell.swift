//
//  SeeAllCell.swift
//  eCommerceDemo
//
//  Created by Hasan Ali Asan on 23.11.2023.
//

import UIKit

class SeeAllCell: UICollectionViewCell {
    // MARK: - Private Properties -
    
    private lazy var rightArrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        imageView.clipsToBounds = true
        imageView.image = .arrowRight
        imageView.tintColor = UIColor.color0551A0
        return imageView
    }()
    
    private lazy var seeAllLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont(.jostBold, size: 18)
        label.textColor = UIColor.color0551A0
        label.text = "Tümünü Gör"
        return label
    }()
    
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
        self.contentView.backgroundColor = .clear
        
        self.contentView.addSubview(self.rightArrowImageView)
        self.contentView.addSubview(self.seeAllLabel)
        
        self.seeAllLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-36)
        }
        
        self.rightArrowImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.leading.equalTo(self.seeAllLabel.snp.trailing)
            $0.centerY.equalTo(self.seeAllLabel.snp.centerY)
            $0.width.height.equalTo(26)
        }
    }
}
