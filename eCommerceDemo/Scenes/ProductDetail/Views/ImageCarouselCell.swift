//
//  ImageCarouselCell.swift
//  eCommerceDemo
//
//  Created by Hasan Ali Asan on 25.11.2023.
//  Copyright © 2023 Hasan Ali Asan. All rights reserved.
//

import UIKit

class ImageCarouselCell: BaseTableViewCell {
    // MARK: - Private Properties -
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.registerCell(with: ImageCarouselItemCell.self)
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    private lazy var pageControl: PrimaryPageControl = {
        let pageControl = PrimaryPageControl()
        pageControl.addTarget(self, action: #selector(pageControlValueChanged), for: .valueChanged)
        return pageControl
    }()
    
    private var images: [URL?] = []
    
    //
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.commonInit()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        self.contentView.addSubview(self.collectionView)
        self.contentView.addSubview(self.pageControl)
        
        self.collectionView.snp.makeConstraints {
            $0.trailing.leading.equalToSuperview()
            $0.top.equalToSuperview().offset(50)
            $0.height.equalTo(200)
        }
        
        self.pageControl.snp.makeConstraints {
            $0.top.equalTo(self.collectionView.snp.bottom).offset(16)
            $0.trailing.leading.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-20)
        }
    }
    
    func configure(images: [URL?]) {
        self.images = images
        self.pageControl.numberOfPages = images.count
        
        self.collectionView.reloadData()
    }
    
    @objc
    private func pageControlValueChanged(_ sender: UIPageControl) {
        let current = sender.currentPage
        let indexPath = IndexPath(row: current, section: 0)
        self.collectionView.scrollToItem(at: indexPath,
                                         at: .left,
                                         animated: true)
    }
}

extension ImageCarouselCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(withClassAndIdentifier: ImageCarouselItemCell.self, for: indexPath)
        let item = self.images[indexPath.row]
        cell.configure(url: item)
        return cell
    }
}

extension ImageCarouselCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension ImageCarouselCell {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageIndex: Int = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = pageIndex
    }
}
