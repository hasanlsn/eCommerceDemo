//
//  HomeViewController.swift
//  eCommerceDemo
//
//  Created by Hasan Ali Asan on 23.11.2023.
//  Copyright (c) 2023 Hasan Ali Asan. All rights reserved.
//

import UIKit
import SnapKit

protocol HomeDisplayLogic: AnyObject {
    
}

final class HomeViewController: BaseViewController {
    // MARK: - IBOutlets -
    
    //
    
    // MARK: - Public Properties -
    
    var interactor: HomeBusinessLogic?
    var router: (NSObjectProtocol & HomeRoutingLogic & HomeDataPassing)?
    
    //
    
    // MARK: - Private Properties -
    
    private lazy var containerScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        return scrollView
    }()
    
    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var categoriesView: CategoriesView = {
        let categoriesView = CategoriesView()
        return categoriesView
    }()
    
    private lazy var productOffersView: ProductOffersView = {
        let offersView = ProductOffersView()
        return offersView
    }()
    
    private lazy var brandBannersView: BrandBannersView = {
        let bannersView = BrandBannersView()
        return bannersView
    }()
    
    private lazy var authView: AuthView = {
        let authView = AuthView()
        authView.delegate = self
        return authView
    }()
    
    private lazy var walletView: WalletView = {
        let walletView = WalletView()
        walletView.delegate = self
        return walletView
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
        let interactor = HomeInteractor()
        let presenter = HomePresenter()
        let router = HomeRouter()
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    //
    
    // MARK: - Helpers -
    
    private func prepareViews() {
        self.view.backgroundColor = .white
        
        let leftView = UIBarButtonItem(customView: self.authView)
        self.navigationItem.leftBarButtonItem = leftView
        
        let rightView = UIBarButtonItem(customView: self.walletView)
        self.navigationItem.rightBarButtonItems = [rightView]
        
        self.view.addSubview(self.containerScrollView)
        self.containerScrollView.addSubview(self.containerStackView)
        self.containerStackView.addArrangedSubview(self.categoriesView)
        self.containerStackView.addArrangedSubview(self.productOffersView)
        self.containerStackView.addArrangedSubview(self.brandBannersView)
        
        self.containerScrollView.snp.makeConstraints {
            $0.trailing.leading.top.bottom.equalToSuperview()
        }
        
        self.containerStackView.snp.makeConstraints {
            $0.trailing.leading.top.bottom.equalToSuperview()
            $0.width.equalTo(self.view.snp.width)
            $0.height.equalTo(self.view.snp.height).priority(.low)
        }
    }
    
    //
    
    // MARK: - IBActions -
    
    //
}

// MARK: - HomeDisplayLogic -

extension HomeViewController: HomeDisplayLogic {

}

//

extension HomeViewController: AuthViewDelegate {
    func didTapLogin(_ authView: AuthView) {
        self.router?.navigate(to: .login)
    }
}

extension HomeViewController: WalletViewDelegate {
    func didTapLogin(_ walletView: WalletView) {
        
    }
}
