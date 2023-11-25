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
    func didTapLogin(request: Login.Phone.Request)
}

protocol LoginDataStore: AnyObject { }

final class LoginInteractor {
    var presenter: LoginPresentationLogic?
    private lazy var worker: LoginWorkProtocol = LoginWorker()
}

// MARK: - LoginBusinessLogic -

extension LoginInteractor: LoginBusinessLogic, LoginDataStore { 
    func viewDidLoad() {
        
    }
    
    func didTapLogin(request: Login.Phone.Request) {
        self.login(phone: request.phone)
    }
}

//

extension LoginInteractor {
    private func login(phone: String) {
        self.worker.login(phone: phone) { [weak self] result in
            switch result {
            case .success(let loginResponseModel):
                let loginInfo = loginResponseModel.toJSONString() ?? ""
                self?.worker.saveLoginInfo(info: loginInfo)
                
                self?.presenter?.presentLoginFinish()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
