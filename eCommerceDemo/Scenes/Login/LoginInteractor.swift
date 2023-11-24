//
//  LoginInteractor.swift
//  eCommerceDemo
//
//  Created by Hasan Ali Asan on 25.11.2023.
//  Copyright (c) 2023 Hasan Ali Asan. All rights reserved.
//

import Foundation

protocol LoginBusinessLogic: AnyObject { 
    func viewDidLoad()
}

protocol LoginDataStore: AnyObject { }

final class LoginInteractor {
    var presenter: LoginPresentationLogic?
    var worker: LoginWorker?
}

// MARK: - LoginBusinessLogic -

extension LoginInteractor: LoginBusinessLogic, LoginDataStore { 
    func viewDidLoad() {
        
    }
}

//
