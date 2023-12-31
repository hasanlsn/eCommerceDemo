//
//  PrimaryButton.swift
//  eCommerceDemo
//
//  Created by Hasan Ali Asan on 23.11.2023.
//

import UIKit

class PrimaryButton: UIButton {
    override var isEnabled: Bool {
        didSet {
            if self.isEnabled == true {
                self.backgroundColor = UIColor.color0551A0
            } else {
                self.backgroundColor = UIColor.colorB0B9C1
            }
        }
    }
    
    init() {
        super.init(frame: .zero)
        
        self.commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.commonInit()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        self.snp.makeConstraints {
            $0.height.equalTo(48)
        }
        
        self.roundCorners(corners: .allCorners, radius: 4)
        self.setTitleColor(.white, for: .normal)
        self.setTitleColor(.white, for: .disabled)
        
        if #available(iOS 15.0, *) {
            var config = UIButton.Configuration.plain()
            config.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
            config.titleTextAttributesTransformer =
            UIConfigurationTextAttributesTransformer { incoming in
                var outgoing = incoming
                outgoing.font = UIFont(.jostBold, size: 16)
                return outgoing
            }
            
            self.configuration = config
        } else {
            self.contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
            self.titleLabel?.font = UIFont(.jostBold, size: 16)
        }
    }
}
