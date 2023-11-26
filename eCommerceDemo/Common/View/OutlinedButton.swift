//
//  OutlinedButton.swift
//  eCommerceDemo
//
//  Created by Hasan Ali Asan on 26.11.2023.
//

import UIKit

class OutlinedButton: UIButton {
    var color: UIColor = .black {
        didSet {
            self.setTitleColor(color, for: .normal)
            self.addBorder(width: 1, color: color)
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
        self.roundCorners(radius: 4)
        
        if #available(iOS 15.0, *) {
            var config = UIButton.Configuration.plain()
            config.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
            config.titleTextAttributesTransformer =
            UIConfigurationTextAttributesTransformer { incoming in
                var outgoing = incoming
                outgoing.font = UIFont(.jostBold, size: 12)
                return outgoing
            }
            
            self.configuration = config
        } else {
            self.contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
            self.titleLabel?.font = UIFont(.jostBold, size: 16)
        }
    }
}
