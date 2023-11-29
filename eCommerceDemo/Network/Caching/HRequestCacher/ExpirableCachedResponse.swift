//
//  ExpirableCachedResponse.swift
//  eCommerceDemo
//
//  Created by Hasan Ali Asan on 29.11.2023.
//  Copyright © 2023 Hasan Ali Asan. All rights reserved.
//

import Foundation

class ExpirableCachedResponse {
    var data: Data?
    var response: URLResponse?
    var storagePolicy: URLCache.StoragePolicy = .allowed
    
    init(data: Data? = nil,
         response: URLResponse? = nil,
         storagePolicy: URLCache.StoragePolicy) {
        self.data = data
        self.response = response
        self.storagePolicy = storagePolicy
    }
}
