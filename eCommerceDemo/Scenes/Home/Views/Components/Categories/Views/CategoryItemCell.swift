//
//  CategoryItemCell.swift
//  eCommerceDemo
//
//  Created by Hasan Ali Asan on 23.11.2023.
//

import UIKit

class CategoryItemCell: UICollectionViewCell {
    // MARK: - Private Properties -
    
    private lazy var categoryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    private lazy var categoryTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(.jostMedium, size: 11)
        label.textColor = UIColor.color555555
        label.numberOfLines = 2
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
        self.contentView.roundCorners(corners: .allCorners, radius: 4)
        
        self.contentView.addSubview(self.categoryImageView)
        self.contentView.addSubview(self.categoryTitleLabel)
        
        self.categoryImageView.snp.makeConstraints {
            $0.trailing.leading.top.bottom.equalToSuperview()
        }
        
        self.categoryTitleLabel.snp.makeConstraints {
            $0.trailing.leading.equalToSuperview().inset(2)
            $0.bottom.equalToSuperview().offset(-6)
            $0.height.equalTo(32)
        }
    }
    
    func configure(viewModel: CategoryItemCellProtocol) {
        self.categoryTitleLabel.text = viewModel.title
        self.categoryImageView.loadImage(url: viewModel.imageURL)
    }
}

protocol CategoryItemCellProtocol {
    var title: String? { get }
    var imageURL: URL? { get }
}
