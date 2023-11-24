//
//  PrimaryTextField.swift
//  eCommerceDemo
//
//  Created by Hasan Ali Asan on 23.11.2023.
//

import UIKit

class PrimaryTextField: UITextField {
    // MARK: - Private Properties -
    
    private var rightViewButton: UIButton!
    
    //
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.commonInit()
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rightViewSpacing: CGFloat = self.rightView == nil ? 0 : 12
        let rightViewWidth = self.rightView?.frame.size.width ?? 0
        
        let edgeInsets = UIEdgeInsets(top: 0,
                                      left: 12,
                                      bottom: 0,
                                      right: rightViewWidth + rightViewSpacing + 12)
        return bounds.inset(by: edgeInsets)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        let rightBounds = CGRect(x: bounds.width - 32, y: (bounds.height - 20) / 2, width: 20, height: 20)
        return rightBounds
    }
    
    private func commonInit() {
        self.snp.makeConstraints {
            $0.height.equalTo(48)
        }
        
        self.roundCorners(radius: 4)
        
        self.layer.borderWidth = 1
        self.backgroundColor = .white
        self.font = UIFont(.jostRegular, size: 14)
        self.textColor = UIColor.color333333
        self.tintColor = UIColor.color333333
        
        self.rightViewMode = .whileEditing
        
        self.rightViewButton = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        self.rightViewButton.setImage(UIImage.deleteText, for: .normal)
        self.rightViewButton.addTarget(self, action: #selector(self.clearText), for: .touchUpInside)
        self.rightView = rightViewButton
        
        self.setPlaceholder(placeHolder: self.placeholder)
        self.configureEmptyState(withAnimation: false)
        
        self.addTarget(self, action: #selector(self.didBeginEditing), for: .editingDidBegin)
        self.addTarget(self, action: #selector(self.didEndEditing), for: .editingDidEnd)
    }
    
    private func decideTextFieldState() {
        if self.isEditing {
            self.configureEditingState()
            return
        }
        
        let text = self.text ?? ""
        if text.isEmpty {
            self.configureEmptyState()
            return
        }
        
        self.configureEditedState()
    }
    
    private func configureEmptyState(withAnimation: Bool = true) {
        UIView.animate(withDuration: withAnimation ? 0.3 : 0, delay: 0, options: .curveEaseInOut) {
            self.layer.borderColor = UIColor.colorCCCCCC.cgColor
        }
    }
    
    private func configureEditingState() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
            self.layer.borderColor = UIColor.color0551A0.cgColor
        }
    }
    
    private func configureEditedState() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
            self.layer.borderColor = UIColor.color0551A0.cgColor
        }
    }
    
    @objc
    private func didBeginEditing() {
        self.decideTextFieldState()
    }
    
    @objc
    private func didEndEditing() {
        self.decideTextFieldState()
    }
    
    @objc
    private func clearText() {
        self.text = ""
    }
    
    private func setPlaceholder(placeHolder: String?) {
        let placeholderAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.color777777,
                                                                    .font: UIFont(.jostRegular, size: 14)]
        self.attributedPlaceholder = NSAttributedString(string: placeHolder ?? "",
                                                        attributes: placeholderAttributes)
    }
}
