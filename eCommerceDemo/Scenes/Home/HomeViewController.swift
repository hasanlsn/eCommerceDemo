//
//  HomeViewController.swift
//  eCommerceDemo
//
//  Created by Hasan Ali Asan on 23.11.2023.
//  Copyright (c) 2023 Hasan Ali Asan. All rights reserved.
//

import UIKit

protocol HomeDisplayLogic: AnyObject {
    
}

final class HomeViewController: UIViewController {
    // MARK: - IBOutlets -
    
    //
    
    // MARK: - Public Properties -
    
    var interactor: HomeBusinessLogic?
    var router: (NSObjectProtocol & HomeRoutingLogic & HomeDataPassing)?
    
    //
    
    // MARK: - Private Properties -
    
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
    
    //
    
    // MARK: - Helpers -
    
    private func prepareViews() {
        
    }
    
    //
    
    // MARK: - IBActions -
    
    //
}

// MARK: - HomeDisplayLogic -

extension HomeViewController: HomeDisplayLogic {
    
}

//
