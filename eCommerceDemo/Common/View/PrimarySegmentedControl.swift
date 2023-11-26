//
//  PrimarySegmentedControl.swift
//  eCommerceDemo
//
//  Created by Hasan Ali Asan on 25.11.2023.
//  Copyright © 2023 Hasan Ali Asan. All rights reserved.
//

import UIKit

class PrimarySegmentedControl: UISegmentedControl {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.commonInit()
    }
    
    override init(items: [Any]?) {
        super.init(items: items)
        
        self.commonInit()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        self.backgroundColor = .clear
        
        self.setBackgroundImage(UIImage(),
                                for: .normal,
                                barMetrics: .default)
        self.setDividerImage(UIImage(),
                             forLeftSegmentState: .normal,
                             rightSegmentState: .normal,
                             barMetrics: .default)
        
        self.setTitleTextAttributes([.font: UIFont(.jostBold, size: 16),
                                     .foregroundColor: UIColor.color0551A0],
                                    for: .selected)
        self.setTitleTextAttributes([.font: UIFont(.jostBold, size: 16),
                                     .foregroundColor: UIColor.colorCCCCCC],
                                    for: .normal)
    }
}
