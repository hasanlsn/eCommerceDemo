//
//  DrawerPresentable.swift
//  eCommerceDemo
//
//  Created by Hasan Ali Asan on 26.11.2023.
//

import UIKit

protocol DrawerPresentable: AnyObject {
    var panScrollView: UIScrollView? { get }
    var panContentHeight: CGFloat? { get }
}

extension DrawerPresentable where Self: UIViewController {
    func drawerPanSetNeedsLayout() {
        if let drawerVC = self.presentingViewController?.presentedViewController as? DrawerViewController {
            drawerVC.panScrollView = self.panScrollView
            drawerVC.panContentHeight = self.panContentHeight
            
            drawerVC.layoutPanModal()
        }
    }
}
