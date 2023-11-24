//
//  HomeRouter.swift
//  eCommerceDemo
//
//  Created by Hasan Ali Asan on 23.11.2023.
//  Copyright (c) 2023 Hasan Ali Asan. All rights reserved.
//

import UIKit

enum HomeNavigationOption { }

protocol HomeRoutingLogic { 
    func navigate(to option: HomeNavigationOption)
}

protocol HomeDataPassing: AnyObject {
    var dataStore: HomeDataStore? { get }
}

final class HomeRouter: NSObject, HomeDataPassing {
    weak var viewController: HomeViewController?
    var dataStore: HomeDataStore?
}

// MARK: - HomeRoutingLogic -

extension HomeRouter: HomeRoutingLogic {
    func navigate(to option: HomeNavigationOption) { }
}

//
