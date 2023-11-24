//
//  LoginRouter.swift
//  eCommerceDemo
//
//  Created by Hasan Ali Asan on 25.11.2023.
//  Copyright (c) 2023 Hasan Ali Asan. All rights reserved.
//

import UIKit

enum LoginNavigationOption { }

protocol LoginRoutingLogic { 
    func navigate(to option: LoginNavigationOption)
}

protocol LoginDataPassing: AnyObject {
    var dataStore: LoginDataStore? { get }
}

final class LoginRouter: NSObject, LoginDataPassing {
    weak var viewController: LoginViewController?
    var dataStore: LoginDataStore?
}

// MARK: - LoginRoutingLogic -

extension LoginRouter: LoginRoutingLogic {
    func navigate(to option: LoginNavigationOption) { }
}

//
