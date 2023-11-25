//
//  LoginWorker.swift
//  eCommerceDemo
//
//  Created by Hasan Ali Asan on 25.11.2023.
//  Copyright (c) 2023 Hasan Ali Asan. All rights reserved.
//

import Foundation

protocol LoginWorkProtocol {
    func login(phone: String, completion: RequestCompletionBlock<LoginResponseModel>)
    func saveLoginInfo(info: String)
}

final class LoginWorker: LoginWorkProtocol {
    func login(phone: String, completion: RequestCompletionBlock<LoginResponseModel>) {
        HNetworkManager.shared.sendRequest(with: AuthEndpoint.login,
                                           completion: completion)
    }
    
    func saveLoginInfo(info: String) {
        HKeychainManager.setString(item: info, forKey: HConstants.Keychain.LOGIN_INFO_KEY)
    }
}
