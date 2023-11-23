//
//  HNetworkManager.swift
//  eCommerceDemo
//
//  Created by Hasan Ali Asan on 23.11.2023.
//

import Foundation
import Alamofire

enum HNetworkResult<T> {
    case success(T)
    case failure(HNetworkError)
}

typealias RequestCompletionBlock<T> = ((HNetworkResult<T>) -> Void)?

struct HNetworkManager {
    static let shared = HNetworkManager()
    
    static let APIManager: Session = {
        let evaluators: [String: ServerTrustEvaluating] = [HConstants.API_HOST_DEV: DefaultTrustEvaluator()]
        let serverTrustManager = ServerTrustManager(evaluators: evaluators)
        
        let networkLogger = HNetworkLogger()
        let configuration = URLSessionConfiguration.default
        let delegate = Session.default.delegate
        let manager = Session.init(configuration: configuration,
                                   delegate: delegate,
                                   startRequestsImmediately: true,
                                   serverTrustManager: serverTrustManager,
                                   cachedResponseHandler: nil,
                                   eventMonitors: [networkLogger])
        
        return manager
    }()
    
    func sendRequest<T: Decodable>(with endpoint: HEndpointType, completion: RequestCompletionBlock<T>) {
        let request = self.buildRequest(from: endpoint)
        HNetworkManager.APIManager.request(request)
            .responseDecodable(of: T.self, completionHandler: { response in
                switch response.result {
                case .success(let result):
                    completion?(.success(result))
                case .failure(let error):
                    completion?(.failure(.custom(message: error.localizedDescription)))
                }
            })
    }
}

extension HNetworkManager {
    fileprivate func buildRequest(from endpoint: HEndpointType) -> URLRequest {
        var request = URLRequest(url: endpoint.baseURL.appendingPathComponent(endpoint.path),
                                 cachePolicy: endpoint.cachePolicy,
                                 timeoutInterval: endpoint.timeoutInterval)
        request.httpMethod = endpoint.httpMethod.rawValue
        
        return request
    }
}
