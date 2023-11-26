//
//  HomeWorker.swift
//  eCommerceDemo
//
//  Created by Hasan Ali Asan on 23.11.2023.
//  Copyright (c) 2023 Hasan Ali Asan. All rights reserved.
//

import Foundation

protocol HomeWorkProtocol {
    func getLoginInfo() -> LoginResponseModel?
}

final class HomeWorker: HomeWorkProtocol {
    func getLoginInfo() -> LoginResponseModel? {
        let info = HKeychainManager.getString(forKey: HConstants.Keychain.LOGIN_INFO_KEY)
        guard let infoDictionary = info?.toDictionary() else {
            return nil
        }
        
        let model = LoginResponseModel.createWith(JSON: infoDictionary)
        return model
    }
}
