//
//  CachingProtocol.swift
//  eCommerceDemo
//
//  Created by Hasan Ali Asan on 29.11.2023.
//  Copyright © 2023 Hasan Ali Asan. All rights reserved.
//

import Foundation

protocol CachingProtocol {
    associatedtype Key
    associatedtype Value
    associatedtype ReturnType
    
    var isCachingEnabled: Bool { get set }
    var lifeTime: TimeInterval { get set }
    
    func addEntry(key: Key?, value: Value)
    func getEntry(key: Key?) -> ReturnType?
    func removeEntry(key: Key?)
    func emptyCache()
}
