//
//  CategoriesView.swift
//  eCommerceDemo
//
//  Created by Hasan Ali Asan on 24.11.2023.
//  Copyright © 2023 Hasan Ali Asan. All rights reserved.
//

import UIKit

class CategoriesView: UIView {
    private lazy var collectionView: IntrinsicCollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = IntrinsicCollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.registerCell(with: CategoryItemCell.self)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    private var categoriesResponseModel: CategoriesResponseModel?
    
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
    }
    
    private func getCategories() {
        HNetworkManager.shared.sendRequest(with: CategoryEndpoint.getCategories)
        { [weak self] (result: HNetworkResult<CategoriesResponseModel>) in
            switch result {
            case .success(let categoriesResponseModel):
                self?.categoriesResponseModel = categoriesResponseModel
                
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension CategoriesView: ViewLifeCycleProtocol {
    func viewDidLoad() {
        self.getCategories()
    }
    
    func reload() {
        self.getCategories()
    }
}

extension CategoriesView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return self.categoriesResponseModel?.content?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(withClassAndIdentifier: CategoryItemCell.self, for: indexPath)
        if let item = self.categoriesResponseModel?.content?[indexPath.row] {
            cell.configure(viewModel: item)
        }
        
        return cell
    }
}

extension CategoriesView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = (collectionView.bounds.width - (32 + 30)) / 4
        let aspectRatio = CGFloat(78) / CGFloat(100)
        let itemHeight = itemWidth / aspectRatio
        
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = self.categoriesResponseModel?.content?[indexPath.row].url
        HAlert.showSystemAlert(title: "Kategori url: ", message: item, buttonTitle: "Tamam")
    }
}

extension CategoryItemModel: CategoryItemCellProtocol {
    var imageURL: URL? {
        return self.images?.first?.url
    }
}
