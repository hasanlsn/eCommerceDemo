//
//  BrandBannersView.swift
//  eCommerceDemo
//
//  Created by Hasan Ali Asan on 24.11.2023.
//  Copyright © 2023 Hasan Ali Asan. All rights reserved.
//

import UIKit

class BrandBannersView: UIView {
    private lazy var collectionView: IntrinsicCollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = IntrinsicCollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.registerCell(with: BrandBannerItemCell.self)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    private var brandBannersResponseModel: BrandBannersResponseModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.commonInit()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        self.addSubview(self.collectionView)
        
        self.collectionView.snp.makeConstraints {
            $0.trailing.leading.top.bottom.equalToSuperview()
        }
        
        self.getBrandBanners()
    }
    
    private func getBrandBanners() {
        HNetworkManager.shared.sendRequest(with: BrandBannerEndpoint.getBrandBanners)
        { [weak self] (result: HNetworkResult<BrandBannersResponseModel>) in
            switch result {
            case .success(let brandBannersResponseModel):
                self?.brandBannersResponseModel = brandBannersResponseModel
                
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension BrandBannersView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.brandBannersResponseModel?.content?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(withClassAndIdentifier: BrandBannerItemCell.self, for: indexPath)
        if let item = self.brandBannersResponseModel?.content?[indexPath.row] {
            cell.configure(viewModel: item)
        }
        
        return cell
    }
}

extension BrandBannersView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        var itemWidth: CGFloat!
        if indexPath.row == 0 {
            itemWidth = collectionView.bounds.width - 32
        } else {
            itemWidth = (collectionView.bounds.width - (32 + 12)) / 2
        }
        
        return CGSize(width: itemWidth, height: 166)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
}

extension BrandBannerItemModel: BrandBannerItemCellProtocol {
    var imageURL: URL? {
        return self.images?.first?.url
    }
}