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
    
    private lazy var brandLargeImageView: UIImageView = {
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
    
    private lazy var brandImageContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var buttonContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var textContainerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [brandNameLabel, brandDescLabel])
        stackView.axis = .vertical
        stackView.spacing = 12
        return stackView
    }()
    
    private lazy var textAndSmallImageStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [textContainerStackView, brandImageContainer])
        stackView.spacing = 0
        stackView.alignment = .top
        return stackView
    }()
    
    private lazy var leftInfoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [textAndSmallImageStackView, buttonContainerView])
        stackView.axis = .vertical
        stackView.spacing = 12
        return stackView
    }()
    
    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [leftInfoStackView, brandLargeImageView])
        stackView.distribution = .fillProportionally
        stackView.spacing = 16
        return stackView
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
        
        self.contentView.addSubview(self.containerStackView)
        self.buttonContainerView.addSubview(self.actionButton)
        self.brandImageContainer.addSubview(self.brandImageView)
        
        self.containerStackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-10)
            $0.leading.equalToSuperview().offset(10)
            $0.bottom.equalToSuperview().offset(-16)
        }
        
        self.brandImageView.snp.makeConstraints {
            $0.width.equalTo(self).multipliedBy(CGFloat(58) / CGFloat(166))
            $0.height.equalTo(self).multipliedBy(CGFloat(81) / CGFloat(166))
            $0.trailing.leading.equalToSuperview()
            $0.bottom.top.greaterThanOrEqualToSuperview().priority(.low)
            $0.centerY.equalToSuperview()
        }
        
        self.brandLargeImageView.snp.makeConstraints {
            $0.width.equalTo(self).multipliedBy(CGFloat(150) / CGFloat(344)).priority(.low)
        }
        
        self.actionButton.snp.makeConstraints {
            $0.top.greaterThanOrEqualToSuperview().priority(.low)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func configure(viewModel: BrandBannerItemCellProtocol, isLarge: Bool) {
        let color = UIColor.colorFromHex(hex: viewModel.textColor) ?? .black
        
        self.brandNameLabel.text = viewModel.title
        self.brandNameLabel.textColor = color
        
        self.brandDescLabel.text = viewModel.description
        self.brandDescLabel.textColor = color
        
        self.brandImageContainer.isHidden = isLarge == true
        self.brandImageView.loadImage(url: viewModel.imageURL)
        
        self.brandLargeImageView.isHidden = isLarge != true
        self.brandLargeImageView.loadImage(url: viewModel.imageURL)
        
        self.actionButton.setTitle(viewModel.buttonText, for: .normal)
        self.actionButton.color = color
        
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
