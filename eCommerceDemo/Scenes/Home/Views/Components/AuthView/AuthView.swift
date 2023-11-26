//
//  AuthView.swift
//  eCommerceDemo
//
//  Created by Hasan Ali Asan on 25.11.2023.
//  Copyright © 2023 Hasan Ali Asan. All rights reserved.
//

import UIKit

protocol AuthViewDelegate: AnyObject {
    func didTapLogin(_ authView: AuthView)
}

class AuthView: UIView {
    // MARK: - Private Properties -
    
    private lazy var appLogoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.appLogo
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var verticalSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Giriş Yap"
        label.font = UIFont(.jostSemiBold, size: 16)
        label.textColor = .color0551A0
        label.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self,
                                                       action: #selector(self.handleLoginAction))
        label.addGestureRecognizer(gestureRecognizer)
        return label
    }()
    
    private var isLoggedIn: Bool = false
    
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
        self.addSubview(self.appLogoImageView)
        self.addSubview(self.verticalSeparatorView)
        self.addSubview(self.titleLabel)
        
        self.appLogoImageView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalToSuperview().offset(4)
            $0.bottom.equalToSuperview().offset(-4)
            $0.width.equalTo(self.appLogoImageView.snp.height).multipliedBy(1)
        }
        
        self.verticalSeparatorView.snp.makeConstraints {
            $0.leading.equalTo(self.appLogoImageView.snp.trailing).offset(12)
            $0.top.bottom.equalToSuperview().inset(8)
            $0.width.equalTo(1)
        }
        
        self.titleLabel.snp.makeConstraints {
            $0.leading.equalTo(self.verticalSeparatorView.snp.trailing).offset(10)
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
    }
    
    func updateAuthInfo(isLoggedIn: Bool, nameAndSurname: String?) {
        if isLoggedIn == true {
            self.titleLabel.text = "Hoş geldin \(nameAndSurname ?? ""),"
        } else {
            self.titleLabel.text = "Giriş Yap"
        }
        
        self.titleLabel.isUserInteractionEnabled = isLoggedIn == false
    }
    
    // MARK: - Actions -
    
    @objc
    private func handleLoginAction() {
        self.delegate?.didTapLogin(self)
    }
    
    //
}
