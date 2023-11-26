//
//  HKeychainManager.swift
//  eCommerceDemo
//
//  Created by Hasan Ali Asan on 23.11.2023.
//

import Foundation
import KeychainAccess

final class HKeychainManager: NSObject {
    private static let keychain = Keychain(service: "ECOMMERCEDEMO_Keychain_Service")
    
    class func setString(item: String, forKey key: String) {
        do {
            try self.keychain.set(item, key: key)
        } catch {
            print("KEYCHAIN_SET_ERROR: \(error)")
        }
    }
    
    class func setData(data: Data, forKey key: String) {
        do {
            try self.keychain.set(data, key: key)
        } catch {
            print("KEYCHAIN_SET_ERROR: \(error)")
        }
    }
    
    class func getData(forKey key: String) -> Data? {
        do {
            return try self.keychain.getData(key)
        } catch {
            print("KEYCHAIN_GET_ERROR: \(error)")
            return nil
        }
    }
    
    class func getString(forKey key: String) -> String? {
        do {
            return try self.keychain.getString(key)
        } catch {
            print("KEYCHAIN_GET_ERROR: \(error)")
            return nil
        }
    }
    
    class func removeItem(forKey key: String) {
        do {
            try self.keychain.remove(key)
        } catch let error {
            print("KEYCHAIN_REMOVE_ERROR: \(error)")
        }
    }
}
