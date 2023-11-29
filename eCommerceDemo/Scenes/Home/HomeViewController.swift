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
    func displayLoginUpdate(viewModel: Home.User.ViewModel)
}

final class HomeViewController: BaseViewController, ViewLifeCycleSenderProtocol {
    // MARK: - IBOutlets -
    
    //
    
    // MARK: - Public Properties -
    
    var interactor: HomeBusinessLogic?
    var router: (NSObjectProtocol & HomeRoutingLogic & HomeDataPassing)?
    
    var lifeCycleObservedViews: [ViewLifeCycleProtocol] = []
    
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
        return walletView
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
       let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.handleRefresh), for: .valueChanged)
        return refreshControl
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
        
        self.lifeCycleObservedViews.viewDidLoadAll()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    //
    
    // MARK: - Helpers -
    
    private func prepareViews() {
        self.view.backgroundColor = .white
        
        self.containerScrollView.refreshControl = self.refreshControl
        
        let leftView = UIBarButtonItem(customView: self.authView)
        self.navigationItem.leftBarButtonItem = leftView
        
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
        
        self.lifeCycleObservedViews = [self.walletView,
                                       self.categoriesView,
                                       self.productOffersView,
                                       self.brandBannersView]
    }
    
    //
    
    // MARK: - IBActions -
    
    @objc
    private func handleRefresh() {
        self.lifeCycleObservedViews.reloadAll()
        self.refreshControl.endRefreshing()
    }
    
    //
}

// MARK: - HomeDisplayLogic -

extension HomeViewController: HomeDisplayLogic {
    func displayLoginUpdate(viewModel: Home.User.ViewModel) {
        if viewModel.isLoggedIn == true {
            let rightView = UIBarButtonItem(customView: self.walletView)
            self.navigationItem.rightBarButtonItem = rightView
        } else {
            self.navigationItem.rightBarButtonItem = nil
        }
        
        self.authView.updateAuthInfo(isLoggedIn: viewModel.isLoggedIn,
                                     nameAndSurname: viewModel.nameAndSurname)
        
        self.walletView.updateAuthInfo(isLoggedIn: viewModel.isLoggedIn)
        
        self.lifeCycleObservedViews.reloadAll()
    }
}

//

extension HomeViewController: AuthViewDelegate {
    func didTapLogin(_ authView: AuthView) {
        self.router?.navigate(to: .login(delegate: self))
    }
    
    func didTapLogout(_ authView: AuthView) {
        HAlert.showSystemAlert(title: "Uyarı!",
                               message: "Çıkış yapmak istediğinizden emin misiniz?", 
                               leftButton: "İptal",
                               rightButton: "Çıkış Yap",
                               vc: self,
                               style: .alert,
                               completionLeft: nil)
        { [weak self] in
            self?.interactor?.userDidLogout()
        }
    }
}

extension HomeViewController: LoginViewControllerDelegate {
    func userDidLogin(_ viewController: LoginViewController) {
        viewController.dismiss(animated: true) { [weak self] in
            self?.interactor?.userDidLogin()
        }
    }
}
