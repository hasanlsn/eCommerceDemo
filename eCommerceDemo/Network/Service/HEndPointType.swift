//
//  HEndpointType.swift
//  eCommerceDemo
//
//  Created by Hasan Ali Asan on 23.11.2023.
//

import Foundation

protocol HEndpointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var cachePolicy: NSURLRequest.CachePolicy { get }
    var timeoutInterval: TimeInterval { get }
}

extension HEndpointType {
    var baseURL: URL {
        guard let url = URL(string: HConstants.API_URL_DEV) else {
            fatalError("baseURL could not be configured.")
        }
        
        return url
    }
    
    var timeoutInterval: TimeInterval {
        return 200
    }
    
    var cachePolicy: NSURLRequest.CachePolicy {
        return .reloadIgnoringLocalCacheData
    }
}

