//
//  CodableExt.swift
//  eCommerceDemo
//
//  Created by Hasan Ali Asan on 23.11.2023.
//

import Foundation

extension Encodable {
    func toJSONString() -> String? {
        do {
            let encoded = try JSONEncoder().encode(self)
            let str = String(data: encoded, encoding: .utf8)
            return str
        } catch {
            return nil
        }
    }
    
    func toJSON() -> [AnyHashable: Any]? {
        return self.toJSONString()?.toDictionary()
    }
}

extension Decodable {
    static func createWith(JSON: [String: Any]) -> Self? {
        do {
            let data = try JSONSerialization.data(withJSONObject: JSON)
            let decodedObject = try JSONDecoder().decode(self, from: data)
            return decodedObject
        } catch {
            return nil
        }
    }
    
    static func createWith(data: Data?) -> Self? {
        guard let data else {
            return nil
        }
        
        do {
            let decoder = JSONDecoder()
            let model = try decoder.decode(self, from: data)
            return model
        } catch {
            return nil
        }
    }
}
