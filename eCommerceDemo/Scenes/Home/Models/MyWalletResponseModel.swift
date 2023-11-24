//
//  MyWalletResponseModel.swift
//  eCommerceDemo
//
//  Created by Hasan Ali Asan on 23.11.2023.
//

import Foundation

struct MyWalletResponseModel: Decodable {
    let walletId: String?
    let walletNo: String?
    let balance: MyWalletBalanceModel?
}

struct MyWalletBalanceModel: Decodable {
    let value: Double?
    let text: String?
    let currency: String?
    let symbol: String?
}
