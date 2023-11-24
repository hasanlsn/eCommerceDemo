//
//  LoginResponseModel.swift
//  eCommerceDemo
//
//  Created by Hasan Ali Asan on 25.11.2023.
//  Copyright © 2023 Hasan Ali Asan. All rights reserved.
//

import Foundation

struct LoginResponseModel: Codable {
    let buyerId: String?
    let name: String?
    let surname: String?
    let phoneNumber: String?
}
