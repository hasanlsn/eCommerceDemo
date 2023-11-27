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
    func reload()
}

extension ViewLifeCycleProtocol {
    func viewDidLoad() { }
    func viewDidAppear(_ animated: Bool) { }
    func viewWillAppear(_ animated: Bool) { }
    func viewWillDisappear(_ animated: Bool) { }
    func viewDidDisappear(_ animated: Bool) { }
    func reload() { }
}

extension Sequence where Iterator.Element == ViewLifeCycleProtocol {
    func reloadAll() {
        self.forEach {
            $0.reload()
        }
    }
    
    func viewDidLoadAll() {
        self.forEach {
            $0.viewDidLoad()
        }
    }
}

protocol ViewLifeCycleSenderProtocol: UIViewController {
    var lifeCycleObservedViews: [ViewLifeCycleProtocol] { get set }
}
