//
//  NavigationBackView.swift
//  eCommerceDemo
//
//  Created by Hasan Ali Asan on 26.11.2023.
//

import UIKit

class NavigationBackView: UIView {
    // MARK: - Private Properties -
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        button.addTarget(self, action: #selector(self.handleBackAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var verticalSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "-"
        label.font = UIFont(.jostSemiBold, size: 14)
        label.textColor = .color0551A0
        return label
    }()
    
    var backAction: (() -> Void)?
    
    //
    
    // MARK: - Public Properties -
    
    weak var delegate: AuthViewDelegate?
    
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
        self.addSubview(self.backButton)
        self.addSubview(self.verticalSeparatorView)
        self.addSubview(self.titleLabel)
        
        self.backButton.snp.makeConstraints {
            $0.leading.centerY.equalToSuperview()
            $0.width.equalTo(20)
            $0.height.equalTo(14)
        }
        
        self.verticalSeparatorView.snp.makeConstraints {
            $0.leading.equalTo(self.backButton.snp.trailing).offset(12)
            $0.top.bottom.equalToSuperview()
            $0.width.equalTo(1)
        }
        
        self.titleLabel.snp.makeConstraints {
            $0.leading.equalTo(self.verticalSeparatorView.snp.trailing).offset(10)
            $0.trailing.top.bottom.equalToSuperview()
        }
    }
    
    func setTitle(title: String?) {
        self.titleLabel.text = title
    }
    
    // MARK: - Actions -
    
    @objc
    private func handleBackAction() {
        self.backAction?()
    }
    
    //
}
