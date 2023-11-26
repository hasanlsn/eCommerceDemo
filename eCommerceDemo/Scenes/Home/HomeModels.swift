//
//  HomeModels.swift
//  eCommerceDemo
//
//  Created by Hasan Ali Asan on 23.11.2023.
//  Copyright (c) 2023 Hasan Ali Asan. All rights reserved.
//

import Foundation

enum Home {
    enum User {
        struct Request {
            
        }
        
        struct Response {
            let responseModel: LoginResponseModel?
        }
        
        struct ViewModel {
            let isLoggedIn: Bool
            let nameAndSurname: String?
        }
    }
}
