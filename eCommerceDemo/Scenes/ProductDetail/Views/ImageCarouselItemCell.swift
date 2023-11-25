//
//  ImageCarouselItemCell.swift
//  eCommerceDemo
//
//  Created by Hasan Ali Asan on 25.11.2023.
//  Copyright © 2023 Hasan Ali Asan. All rights reserved.
//

import UIKit

class ImageCarouselItemCell: UICollectionViewCell {
    // MARK: - Private Properties -
    
    private lazy var carouselImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    //
    
    func configure(url: URL?) {
        self.contentView.addSubview(self.carouselImageView)
        
        self.carouselImageView.snp.makeConstraints {
            $0.trailing.leading.top.bottom.equalToSuperview()
        }
        
        self.carouselImageView.loadImage(url: url)
    }
}
