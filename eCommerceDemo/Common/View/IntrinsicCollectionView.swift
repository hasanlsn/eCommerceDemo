//
//  IntrinsicCollectionView.swift
//  eCommerceDemo
//
//  Created by Hasan Ali Asan on 23.11.2023.
//

import UIKit

class IntrinsicCollectionView: UICollectionView {
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.commonInit()
    }
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        self.commonInit()
    }
    
    private func commonInit() {
        self.isScrollEnabled = false
        self.isPagingEnabled = false
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        
        if let layout = self.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if !__CGSizeEqualToSize(bounds.size, self.intrinsicContentSize) {
            self.invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return collectionViewLayout.collectionViewContentSize
    }
}
