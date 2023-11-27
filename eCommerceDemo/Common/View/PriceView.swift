//
//  PriceView.swift
//  eCommerceDemo
//
//  Created by Hasan Ali Asan on 24.11.2023.
//  Copyright © 2023 Hasan Ali Asan. All rights reserved.
//

import UIKit

class PriceView: UIView {
    // MARK: - Public Properties -
    
    var isLarge: Bool = false {
        didSet {
            if self.isLarge == true {
                self.originalPriceLabel.font = UIFont(.jostRegular, size: 15)
                self.discountedPriceLabel.font = UIFont(.jostBold, size: 16)
            } else {
                self.originalPriceLabel.font = UIFont(.jostRegular, size: 10)
                self.discountedPriceLabel.font = UIFont(.jostBold, size: 12)
            }
        }
    }
    
    //
    
    // MARK: - Private Properties -
    
    private lazy var innerContainerView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = .colorFAE14B
        view.roundCorners(corners: .allCorners, radius: 4)
        return view
    }()
    
    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [originalPriceContainerView, discountedPriceLabel])
        stackView.axis = .vertical
        stackView.spacing = 3
        return stackView
    }()
    
    private lazy var originalPriceContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .colorCC1512
        view.roundCorners(corners: .allCorners, radius: 2)
        return view
    }()
    
    private lazy var originalPriceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(.jostRegular, size: 10)
        label.textColor = UIColor.colorFAE14B
        return label
    }()
    
    private lazy var leaningLineView: LeaningLineView = {
        let view = LeaningLineView()
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var discountedPriceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(.jostBold, size: 12)
        label.textColor = UIColor.colorCC1512
        return label
    }()
    
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
        self.backgroundColor = .clear
        
        self.addSubview(self.innerContainerView)
        self.innerContainerView.addSubview(self.containerStackView)
        self.originalPriceContainerView.addSubview(self.originalPriceLabel)
        self.originalPriceLabel.addSubview(self.leaningLineView)
        
        self.innerContainerView.snp.makeConstraints {
            $0.centerY.leading.trailing.equalToSuperview()
            $0.top.bottom.greaterThanOrEqualToSuperview().priority(.low)
        }
        
        self.containerStackView.snp.makeConstraints {
            $0.leading.top.equalToSuperview().offset(3)
            $0.trailing.bottom.equalToSuperview().offset(-3)
        }
        
        self.leaningLineView.snp.makeConstraints {
            $0.trailing.leading.top.bottom.equalToSuperview()
        }
        
        self.originalPriceLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(2)
            $0.centerX.equalToSuperview()
            $0.leading.greaterThanOrEqualToSuperview().offset(2).priority(.low)
            $0.trailing.greaterThanOrEqualToSuperview().offset(-2).priority(.low)
            $0.bottom.equalToSuperview().offset(-2)
        }
    }
    
    func setPrice(originalPrice: String?, discountedPrice: String?) {
        self.originalPriceLabel.text = originalPrice
        self.originalPriceContainerView.isHidden = discountedPrice.nilOrIsEmpty
        
        self.discountedPriceLabel.text = discountedPrice.nilOrIsEmpty ? originalPrice : discountedPrice
    }
}

class LeaningLineView: UIView {
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        context?.setLineWidth(1.0)
        context?.setStrokeColor(UIColor.color0551A0.cgColor)
        context?.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        context?.addLine (to: CGPoint(x: rect.maxX, y: rect.minY))
        context?.strokePath()
    }
}
