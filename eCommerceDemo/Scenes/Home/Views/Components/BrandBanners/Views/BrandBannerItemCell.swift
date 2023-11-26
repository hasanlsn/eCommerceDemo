//
//  BrandBannerItemCell.swift
//  eCommerceDemo
//
//  Created by Hasan Ali Asan on 23.11.2023.
//

import UIKit

protocol BrandBannerItemCellDelegate: AnyObject {
    func didTapSeeAll(_ cell: BrandBannerItemCell)
}

class BrandBannerItemCell: UICollectionViewCell {
    // MARK: - Private Properties -
    
    private lazy var brandImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var brandNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(.jostBold, size: 20)
        label.textColor = UIColor.color333333
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var brandDescLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(.jostRegular, size: 12)
        label.textColor = UIColor.color333333
        label.numberOfLines = 3
        return label
    }()
    
    private lazy var actionButton: OutlinedButton = {
        let button = OutlinedButton()
        button.addTarget(self, action: #selector(self.handleSeeAllAction), for: .touchUpInside)
        return button
    }()
    
    weak var delegate: BrandBannerItemCellDelegate?
    
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
        self.contentView.roundCorners(corners: .allCorners, radius: 8)
        
        self.contentView.addSubview(self.brandImageView)
        self.contentView.addSubview(self.brandNameLabel)
        self.contentView.addSubview(self.brandDescLabel)
        self.contentView.addSubview(self.actionButton)
        
        self.brandImageView.snp.makeConstraints {
            $0.top.equalTo(self.brandNameLabel.snp.top)
            $0.trailing.equalToSuperview().offset(-10)
            $0.width.equalTo(58)
            $0.height.equalTo(90)
        }
        
        self.brandNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(10)
            $0.trailing.equalTo(self.brandImageView.snp.leading).offset(-4)
        }
        
        self.brandDescLabel.snp.makeConstraints {
            $0.top.equalTo(self.brandNameLabel.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(10)
            $0.trailing.equalTo(self.brandImageView.snp.leading).offset(-4)
        }
        
        self.actionButton.snp.makeConstraints {
            $0.top.greaterThanOrEqualTo(self.brandImageView.snp.bottom).offset(10).priority(.low)
            $0.leading.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().offset(-10)
            $0.bottom.equalToSuperview().offset(-16)
        }
    }
    
    func configure(viewModel: BrandBannerItemCellProtocol) {
        self.brandNameLabel.text = viewModel.title
        self.brandDescLabel.text = viewModel.description
        
        self.brandImageView.loadImage(url: viewModel.imageURL)
        self.actionButton.setTitle(viewModel.buttonText, for: .normal)
        
        let textColor = UIColor.colorFromHex(hex: viewModel.textColor) ?? .black
        self.actionButton.color = textColor
        
        let bgColor = UIColor.colorFromHex(hex: viewModel.backgroundColor)
        self.contentView.backgroundColor = bgColor
    }
    
    @objc
    private func handleSeeAllAction() {
        self.delegate?.didTapSeeAll(self)
    }
}

protocol BrandBannerItemCellProtocol {
    var title: String? { get }
    var description: String? { get }
    var buttonText: String? { get }
    var textColor: String? { get }
    var backgroundColor: String? { get }
    var imageURL: URL? { get }
}
