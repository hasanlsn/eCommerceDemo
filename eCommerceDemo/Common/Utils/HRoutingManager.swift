//
//  HRoutingManager.swift
//  eCommerceDemo
//
//  Created by Hasan Ali Asan on 26.11.2023.
//

import UIKit

struct HRoutingManager {
    static func routeToProductDetail() {
        let destination = ProductDetailViewController()
        HRoutingManager.push(viewController: destination)
    }
    
    private static func push(viewController: UIViewController) {
        guard let topViewController = UIViewController.topViewController() else {
            return
        }
        
        let navigationController = (topViewController as? UINavigationController) ?? topViewController.navigationController
        navigationController?.pushViewController(viewController, animated: true)
    }
}
