//
//  UITableViewExt.swift
//  eCommerceDemo
//
//  Created by Hasan Ali Asan on 25.11.2023.
//  Copyright © 2023 Hasan Ali Asan. All rights reserved.
//

import UIKit

extension UITableView {
    func registerCell(with cellClass: AnyClass) {
        self.register(cellClass, forCellReuseIdentifier: String(describing: cellClass.self))
    }
    
    func dequeueCell<T>(withClassAndIdentifier classAndIdentifier: T.Type, for indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withIdentifier: String(describing: T.self), for: indexPath) as! T
    }
    
    func registerHeaderFooterView(with cellClass: AnyClass) {
        self.register(cellClass, forHeaderFooterViewReuseIdentifier: String(describing: cellClass.self))
    }
    
    func dequeueHeaderFooterView<T: UITableViewHeaderFooterView>(with type: T.Type) -> T {
        return dequeueReusableHeaderFooterView(withIdentifier: String(describing: type)) as! T
    }
}
