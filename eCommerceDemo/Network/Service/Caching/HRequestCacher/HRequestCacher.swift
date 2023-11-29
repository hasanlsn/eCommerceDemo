//
//  HNetworkCacheManager.swift
//  eCommerceDemo
//
//  Created by Hasan Ali Asan on 29.11.2023.
//  Copyright © 2023 Hasan Ali Asan. All rights reserved.
//

import Foundation

class HRequestCacher: CachingProtocol {
    typealias Key = URLRequest
    typealias Value = ExpirableCachedResponse
    typealias ReturnType = CachedURLResponse
    
    static let shared = HRequestCacher()
    
    var isCachingEnabled: Bool = true
    var lifeTime: TimeInterval = 3600
    
    private lazy var cache: URLCache = {
        let memoryCacheSize = 50 * 1024 * 1024
        let diskCacheSize = 250 * 1024 * 1024
        let cacheDirectory = FileManager.default.urls(for: .cachesDirectory,
                                                      in: .userDomainMask).first?.appendingPathComponent("requests/")
        return URLCache(memoryCapacity: 0, diskCapacity: diskCacheSize, diskPath: cacheDirectory?.absoluteString)
    }()
    
    func addEntry(key: URLRequest?, value: ExpirableCachedResponse) {
        if self.isCachingEnabled == false {
            return
        }
        
        guard let key,
              let response = value.response,
              let data = value.data else {
            return
        }
        
        let expireDate = Date().addingTimeInterval(self.lifeTime)
        let userInfo = ["expireDate": expireDate]
        let cachedResponse = CachedURLResponse(response: response,
                                               data: data,
                                               userInfo: userInfo,
                                               storagePolicy: value.storagePolicy)
        self.cache.storeCachedResponse(cachedResponse, for: key)
    }
    
    func getEntry(key: URLRequest?) -> CachedURLResponse? {
        if self.isCachingEnabled == false {
            return nil
        }
        
        guard let key else {
            return nil
        }
        
        let now = Date()
        let cachedItem = self.cache.cachedResponse(for: key)
        if let expireDate = cachedItem?.userInfo?["expireDate"] as? Date,
           now < expireDate {
            return cachedItem
        }
        
        return nil
    }
    
    func removeEntry(key: URLRequest?) {
        if self.isCachingEnabled == false {
            return
        }
        
        guard let key else {
            return
        }
        
        self.cache.removeCachedResponse(for: key)
    }
    
    func emptyCache() {
        self.cache.removeAllCachedResponses()
    }
}
