//
//  PrimaryPageControl.swift
//  eCommerceDemo
//
//  Created by Hasan Ali Asan on 25.11.2023.
//  Copyright © 2023 Hasan Ali Asan. All rights reserved.
//

import UIKit

class PrimaryPageControl: UIPageControl {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.commonInit()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        self.currentPageIndicatorTintColor = UIColor.color0551A0
        self.pageIndicatorTintColor = UIColor.colorE5E5E5
        self.clipsToBounds = false
        
        if #available(iOS 16.0, *) {
            self.preferredIndicatorImage = .pageIndicator
            self.preferredCurrentPageIndicatorImage = .selectedPageIndicator
        }
    }
}
