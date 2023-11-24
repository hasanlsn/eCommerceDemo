//
//  OfferProductItemCell.swift
//  eCommerceDemo
//
//  Created by Hasan Ali Asan on 23.11.2023.
//

import UIKit

class OfferProductItemCell: UICollectionViewCell {
    // MARK: - Private Properties -
    
    private lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .clear
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var productNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(.jostMedium, size: 12)
        label.textColor = UIColor.darkCharcoal
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var priceView: PriceView = {
        let view = PriceView()
        return view
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
        self.contentView.backgroundColor = .white
        
        self.contentView.addShadowWithRoundedCorners(color: UIColor.lightGray,
                                                     corners: .allCorners,
                                                     radius: 7)
        
        self.contentView.addSubview(self.productImageView)
        self.contentView.addSubview(self.productNameLabel)
        self.contentView.addSubview(self.priceView)
        
        self.productImageView.snp.makeConstraints {
            $0.trailing.leading.top.equalToSuperview().inset(10)
            $0.width.height.equalTo(92)
        }
        
        self.productNameLabel.snp.makeConstraints {
            $0.top.equalTo(self.productImageView.snp.bottom).offset(6)
            $0.leading.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().offset(-10)
        }
        
        self.priceView.snp.makeConstraints {
            $0.top.equalTo(self.productNameLabel.snp.bottom).offset(6)
            $0.leading.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().offset(-10)
            $0.bottom.equalToSuperview().offset(-10)
        }
    }
    
    func configure(viewModel: OfferProductItemCellProtocol) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.81
        paragraphStyle.alignment = .center
        self.productNameLabel.attributedText = NSMutableAttributedString(string: viewModel.name ?? "",
                                                         attributes: [.paragraphStyle: paragraphStyle])
        
        self.productImageView.loadImage(url: viewModel.imageURL)
        
        var originalPrice: String?
        if let price = viewModel.originalPrice, price.isEmpty == false,
           let symbol = viewModel.originalPriceSymbol {
            originalPrice = "\(price)\(symbol)"
        }
        
        var discountedPrice: String?
        if let price = viewModel.discountedPrice, price.isEmpty == false,
           let symbol = viewModel.discountedPriceSymbol {
            discountedPrice = "\(price)\(symbol)"
        }
        
        self.priceView.setPrice(originalPrice: originalPrice, discountedPrice: discountedPrice)
    }
}

protocol OfferProductItemCellProtocol {
    var name: String? { get }
    var imageURL: URL? { get }
    var originalPrice: String? { get }
    var originalPriceSymbol: String? { get }
    var discountedPrice: String? { get }
    var discountedPriceSymbol: String? { get }
}
