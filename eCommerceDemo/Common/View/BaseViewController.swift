//
//  BaseViewController.swift
//  eCommerceDemo
//
//  Created by Hasan Ali Asan on 25.11.2023.
//  Copyright © 2023 Hasan Ali Asan. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    var hideTitleView: Bool = false {
        didSet {
            if hideTitleView == true {
                self.navigationItem.titleView = UIView()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
    }
}
