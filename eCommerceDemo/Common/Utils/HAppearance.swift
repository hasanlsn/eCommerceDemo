//
//  HAppearance.swift
//  eCommerceDemo
//
//  Created by Hasan Ali Asan on 23.11.2023.
//

import UIKit

class HAppearance: NSObject {
    static func updateGlobalViewAppearance() {
        // navigation bar
        HAppearance.setNavigationBarAppearance(bgColor: UIColor.minionYellow)
    }
    
    private static func setNavigationBarAppearance(bgColor: UIColor) {
        if #available(iOS 15, *) {
            let navigationBarAppearance = UINavigationBarAppearance()
            navigationBarAppearance.configureWithOpaqueBackground()
            navigationBarAppearance.titleTextAttributes = [
                .foregroundColor: UIColor.white,
                .font: UIFont(.jostBold, size: 18)
            ]
            navigationBarAppearance.backgroundColor = bgColor
            UINavigationBar.appearance().standardAppearance = navigationBarAppearance
            UINavigationBar.appearance().compactAppearance = navigationBarAppearance
            UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
        } else {
            UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white,
                                                                .font: UIFont(.jostBold, size: 18)]
            UINavigationBar.appearance().barTintColor = bgColor
        }
        
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().tintColor = .white
    }
}
