//
//  LoginViewController.swift
//  eCommerceDemo
//
//  Created by Hasan Ali Asan on 25.11.2023.
//  Copyright (c) 2023 Hasan Ali Asan. All rights reserved.
//

import UIKit

protocol LoginDisplayLogic: AnyObject { }

final class LoginViewController: BaseViewController {
    // MARK: - IBOutlets -
    
    //
    
    // MARK: - Public Properties -
    
    var interactor: LoginBusinessLogic?
    var router: (NSObjectProtocol & LoginRoutingLogic & LoginDataPassing)?
    
    //
    
    // MARK: - Private Properties -
    
    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [phoneTextField, loginButton])
        stackView.axis = .vertical
        stackView.spacing = 24
        return stackView
    }()
    
    private lazy var phoneTextField: PrimaryTextField = {
        let textField = PrimaryTextField()
        textField.placeholder = "Telefon Numarası"
        textField.delegate = self
        textField.returnKeyType = .done
        textField.keyboardType = .numberPad
        return textField
    }()
    
    private lazy var loginButton: PrimaryButton = {
        let button = PrimaryButton()
        button.isEnabled = false
        button.setTitle("Giriş Yap", for: .disabled)
        button.setTitle("Devam Et", for: .normal)
        return button
    }()
    
    //
    
    // MARK: - Object lifecycle -

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    //
    
    // MARK: - Setup -
    
    private func setup() {
        let viewController = self
        let interactor = LoginInteractor()
        let presenter = LoginPresenter()
        let router = LoginRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    //
    
    // MARK: - View lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.prepareViews()
        
        self.interactor?.viewDidLoad()
    }
    
    //
    
    // MARK: - Helpers -
    
    private func prepareViews() {
        self.navigationItem.title = "Giriş Yap"
        
        let closeButton = UIBarButtonItem(image: UIImage(systemName: "xmark"),
                                          style: .plain,
                                          target: self,
                                          action: #selector(self.handleCloseAction))
        self.navigationItem.rightBarButtonItem = closeButton
        
        self.view.addSubview(self.containerStackView)
        
        self.containerStackView.snp.makeConstraints {
            $0.leading.top.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().offset(-24)
        }
    }
    
    private func checkLoginButton() {
        self.loginButton.isEnabled = self.phoneTextField.text?.toCleanText().isValidPhone() == true
    }
    
    //
    
    // MARK: - IBActions -
    
    @objc
    private func handleCloseAction() {
        self.dismiss(animated: true)
    }
    
    //
}

// MARK: - LoginDisplayLogic -

extension LoginViewController: LoginDisplayLogic { }

//

extension LoginViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        if string != "", string.containsOnlyDigits() == false {
            return false
        }
        
        let newString = textField.newString(range: range, replacementString: string)
        let cleanString = newString.replacingOccurrences(of: " ", with: "")
        if cleanString.containsOnlyDigits() {
            let result = HConstants.TextFormatter.TURKEY_PHONE_NUMBER_FORMATTER.format(cleanString)
            textField.text = result
            
            self.checkLoginButton()
            
            return false
        }
        
        self.checkLoginButton()
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
