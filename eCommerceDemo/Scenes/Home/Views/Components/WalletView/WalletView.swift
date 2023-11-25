//
//  WalletView.swift
//  eCommerceDemo
//
//  Created by Hasan Ali Asan on 25.11.2023.
//  Copyright © 2023 Hasan Ali Asan. All rights reserved.
//

import UIKit

protocol WalletViewDelegate: AnyObject {
    func didTapLogin(_ walletView: WalletView)
}

class WalletView: UIView {
    // MARK: - Private Properties -
    
    private lazy var bgImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.walletBg
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var containerView: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor.color0551A0
        view.roundCorners(radius: 8)
        return view
    }()
    
    private lazy var walletImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.wallet
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var textStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, balanceLabel])
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Cüzdanım"
        label.font = UIFont(.jostBold, size: 11)
        label.textColor = .white
        return label
    }()
    
    private lazy var balanceLabel: UILabel = {
        let label = UILabel()
        label.text = "-"
        label.font = UIFont(.jostBold, size: 12)
        label.textColor = UIColor.colorFFE000
        return label
    }()
    
    private var walletResponseModel: MyWalletResponseModel?
    
    //
    
    // MARK: - Public Properties -
    
    weak var delegate: WalletViewDelegate?
    
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
        self.addSubview(self.containerView)
        self.containerView.addSubview(self.bgImageView)
        self.containerView.addSubview(self.walletImageView)
        self.containerView.addSubview(self.textStackView)
        
        self.containerView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalToSuperview().offset(4)
            $0.bottom.equalToSuperview().offset(-4)
            $0.trailing.equalToSuperview().offset(16 + 8)
        }
        
        self.bgImageView.snp.makeConstraints {
            $0.trailing.leading.top.bottom.equalToSuperview()
        }
        
        self.walletImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(8)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(22)
            $0.height.equalTo(20)
        }
        
        self.textStackView.snp.makeConstraints {
            $0.leading.equalTo(self.walletImageView.snp.trailing).offset(8)
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        self.getMyWallet()
    }
    
    // MARK: - Actions -
    
    @objc
    private func handleLoginAction() {
        self.delegate?.didTapLogin(self)
    }
    
    //
    
    private func getMyWallet() {
        HNetworkManager.shared.sendRequest(with: ProfileEndpoint.getMyWallet)
        { [weak self] (result: HNetworkResult<MyWalletResponseModel>) in
            switch result {
            case .success(let walletResponseModel):
                self?.walletResponseModel = walletResponseModel
                
                if let balance = walletResponseModel.balance?.text,
                   let symbol = walletResponseModel.balance?.symbol {
                    self?.balanceLabel.text = "\(balance)\(symbol)"
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
