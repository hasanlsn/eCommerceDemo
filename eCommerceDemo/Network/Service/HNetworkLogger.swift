//
//  HNetworkLogger.swift
//  eCommerceDemo
//
//  Created by Hasan Ali Asan on 23.11.2023.
//

import Foundation
import Alamofire

class HNetworkLogger: EventMonitor {
    let queue = DispatchQueue(label: "com.hasanlsn.eCommerceDemo")
    
    func requestDidFinish(_ request: Request) {
#if DEBUG
        var bodyStr = ""
        if let body = request.request?.httpBody {
            bodyStr = String(data: body, encoding: .utf8) ?? ""
        }
        
        let message = """
        ----------HTTP REQUEST START----------
        url: \(request.request?.url?.absoluteString ?? "")
        headers: \(request.request?.allHTTPHeaderFields?.toJSONString ?? "")
        method: \(request.request?.method?.rawValue ?? "")
        body: \(bodyStr)
        ----------HTTP REQUEST END----------
        """
        
        print(message)
#endif
    }
    
    func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value, AFError>) {
#if DEBUG
        var message = """
        ----------HTTP RESPONSE START----------
        status: \(response.response?.statusCode ?? -1)
        url: \(response.response?.url?.absoluteString ?? "")
        headers: \(response.response?.allHeaderFields.toJSONString ?? "")
        data: {{data}}
        error: {{error}}
        ----------HTTP RESPONSE END----------
        """
        
        if let data = response.data,
           let json = String(data: data, encoding: .utf8) {
            message = message.replacingOccurrences(of: "{{data}}", with: json)
        }
        
        print(message)
#endif
    }
}
