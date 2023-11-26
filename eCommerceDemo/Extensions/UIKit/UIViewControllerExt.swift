//
//  UIViewControllerEx.swift
//  eCommerceDemo
//
//  Created by Hasan Ali Asan on 26.11.2023.
//  Copyright © 2023 Hasan Ali Asan. All rights reserved.
//

import UIKit

extension UIViewController {
    func topMostViewController() -> UIViewController? {
        if let navigation = self.presentedViewController as? UINavigationController {
            return navigation.visibleViewController?.topMostViewController()
        }
        if let tab = self.presentedViewController as? UITabBarController {
            if let selectedTab = tab.selectedViewController {
                return selectedTab.topMostViewController()
            }
            return tab.topMostViewController()
        }
        
        if self.presentedViewController == nil {
            return self
        }
        
        return self.presentedViewController!.topMostViewController()
    }
    
    static func topViewController() -> UIViewController? {
        return UIApplication.shared.windows.filter { $0.isKeyWindow }.first?.rootViewController?.topMostViewController()
    }
    
    func addWithView(_ child: UIViewController, to: UIView? = nil) {
        guard let destinationView = to,
              let childView = child.view else {
            return
        }
        
        self.addChild(child)
        
        childView.translatesAutoresizingMaskIntoConstraints = false
        destinationView.addSubview(childView)
        
        NSLayoutConstraint.activate([childView.topAnchor.constraint(equalTo: destinationView.topAnchor),
                                     childView.bottomAnchor.constraint(equalTo: destinationView.bottomAnchor),
                                     childView.trailingAnchor.constraint(equalTo: destinationView.trailingAnchor),
                                     childView.leadingAnchor.constraint(equalTo: destinationView.leadingAnchor)])
        
        child.didMove(toParent: self)
    }
}
