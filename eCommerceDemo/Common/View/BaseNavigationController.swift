//
//  BaseNavigationController.swift
//  eCommerceDemo
//
//  Created by Hasan Ali Asan on 24.11.2023.
//  Copyright © 2023 Hasan Ali Asan. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()

        self.interactivePopGestureRecognizer?.delegate = self
        self.delegate = self
    }
}

extension BaseNavigationController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

extension BaseNavigationController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController,
                              willShow viewController: UIViewController,
                              animated: Bool) {
        if navigationController.viewControllers.count <= 1 {
            return
        }
        
        let backView = NavigationBackView()
        backView.setTitle(title: viewController.navigationItem.title)
        backView.backAction = { [weak self] in
            self?.popViewController(animated: true)
        }
        
        let backItem = UIBarButtonItem(customView: backView)
        viewController.navigationItem.leftBarButtonItem = backItem
    }
}
