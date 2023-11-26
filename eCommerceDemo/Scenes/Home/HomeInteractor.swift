//
//  HomeInteractor.swift
//  eCommerceDemo
//
//  Created by Hasan Ali Asan on 23.11.2023.
//  Copyright (c) 2023 Hasan Ali Asan. All rights reserved.
//

import Foundation

protocol HomeBusinessLogic: AnyObject { 
    func viewDidLoad()
    func userDidLogin()
}

protocol HomeDataStore: AnyObject { }

final class HomeInteractor {
    var presenter: HomePresentationLogic?
    private lazy var worker: HomeWorkProtocol = HomeWorker()
}

// MARK: - HomeBusinessLogic -

extension HomeInteractor: HomeBusinessLogic, HomeDataStore { 
    func viewDidLoad() {
        self.checkLogin()
    }
    
    func userDidLogin() {
        self.checkLogin()
    }
    
    private func checkLogin() {
        let userInfo = self.worker.getLoginInfo()
        let response = Home.User.Response(responseModel: userInfo)
        self.presenter?.presentLoginUpdate(response: response)
    }
}

//
