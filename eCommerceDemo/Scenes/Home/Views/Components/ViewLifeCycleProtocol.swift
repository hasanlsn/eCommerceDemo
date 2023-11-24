//
//  ViewLifeCycleProtocol.swift
//  eCommerceDemo
//
//  Created by Hasan Ali Asan on 24.11.2023.
//  Copyright © 2023 Hasan Ali Asan. All rights reserved.
//

import UIKit

protocol ViewLifeCycleProtocol: UIView {
    func viewDidLoad()
    func viewDidAppear(_ animated: Bool)
    func viewWillAppear(_ animated: Bool)
    func viewWillDisappear(_ animated: Bool)
    func viewDidDisappear(_ animated: Bool)
}
