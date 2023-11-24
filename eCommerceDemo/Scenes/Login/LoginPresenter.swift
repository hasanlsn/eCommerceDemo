//
//  LoginPresenter.swift
//  eCommerceDemo
//
//  Created by Hasan Ali Asan on 25.11.2023.
//  Copyright (c) 2023 Hasan Ali Asan. All rights reserved.
//

import Foundation

protocol LoginPresentationLogic: AnyObject {
    func presentLoginFinish()
}

final class LoginPresenter {
    weak var viewController: LoginDisplayLogic?
}

// MARK: - LoginPresentationLogic -

extension LoginPresenter: LoginPresentationLogic {
    func presentLoginFinish() {
        self.viewController?.displayLoginFinish()
    }
}

//
