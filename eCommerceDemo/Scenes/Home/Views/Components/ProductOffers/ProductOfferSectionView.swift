//
//  ProductOfferSectionView.swift
//  eCommerceDemo
//
//  Created by Hasan Ali Asan on 24.11.2023.
//  Copyright © 2023 Hasan Ali Asan. All rights reserved.
//

import UIKit

class ProductOfferSectionView: UIView {
    // MARK: - Private Properties -
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.registerCell(with: OfferProductItemCell.self)
        collectionView.registerCell(with: SeeAllCell.self)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private lazy var bgImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(.jostBold, size: 16)
        label.textColor = .white
        return label
    }()
    
    private var offerItemModel: ProductOfferItemModel!
    
    //
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.commonInit()
    }
    
    init(offerItem: ProductOfferItemModel) {
        super.init(frame: .zero)
        
        self.commonInit()
        
        self.offerItemModel = offerItem
        
        self.bgImageView.loadImage(url: offerItem.images?.first?.url)
        self.titleLabel.text = offerItem.title
        self.titleLabel.textColor = UIColor.colorFromHex(hex: offerItem.bannerTitleColor)
        
        self.collectionView.reloadData()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        self.addSubview(self.bgImageView)
        self.addSubview(self.titleLabel)
        self.addSubview(self.collectionView)
        
        self.titleLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-16)
            $0.leading.equalToSuperview().offset(16)
            $0.top.equalToSuperview().offset(20)
        }
        
        self.bgImageView.snp.makeConstraints {
            $0.trailing.leading.top.equalToSuperview()
            $0.height.equalTo(100)
        }
        
        self.collectionView.snp.makeConstraints {
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(20)
            $0.trailing.leading.equalToSuperview()
            $0.height.equalTo(200)
            $0.bottom.equalTo(-16)
        }
    }
}

extension ProductOfferSectionView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 1 {
            return 1
        }
        
        return self.offerItemModel.skuOffers?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 1 {
            let cell = collectionView.dequeueCell(withClassAndIdentifier: SeeAllCell.self, for: indexPath)
            return cell
        }
        
        let cell = collectionView.dequeueCell(withClassAndIdentifier: OfferProductItemCell.self, for: indexPath)
        if let item = self.offerItemModel?.skuOffers?[indexPath.row] {
            cell.configure(viewModel: item)
        }
        
        return cell
    }
}

extension ProductOfferSectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: 140, height: 194)
        }
        
        return CGSize(width: 112, height: 194)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 22
    }
}

extension SkuOfferModel: OfferProductItemCellProtocol {
    var name: String? {
        return self.product?.name
    }
    
    var imageURL: URL? {
        self.product?.images?.first?.url
    }
    
    var originalPrice: String? {
        return self.prices?.original?.text
    }
    
    var originalPriceSymbol: String? {
        return self.prices?.original?.symbol
    }
    
    var discountedPrice: String? {
        return self.prices?.discounted?.text
    }
    
    var discountedPriceSymbol: String? {
        return self.prices?.discounted?.symbol
    }
}
