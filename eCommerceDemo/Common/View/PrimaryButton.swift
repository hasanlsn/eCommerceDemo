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
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.commonInit()
    }
    
    private func commonInit() {
        self.snp.makeConstraints {
            $0.height.equalTo(48)
        }
        
        self.roundCorners(radius: 4)
        self.setTitleColor(.white, for: .normal)
        self.setTitleColor(.white, for: .disabled)
        
        if #available(iOS 15.0, *) {
            var config = UIButton.Configuration.plain()
            config.titleTextAttributesTransformer =
            UIConfigurationTextAttributesTransformer { incoming in
                var outgoing = incoming
                outgoing.font = UIFont(.jostBold, size: 16)
                return outgoing
            }
            
            self.configuration = config
        } else {
            self.contentEdgeInsets = UIEdgeInsets(top: 4, left: 6, bottom: 4, right: 6)
            self.titleLabel?.font = UIFont(.jostBold, size: 16)
        }
    }
}
