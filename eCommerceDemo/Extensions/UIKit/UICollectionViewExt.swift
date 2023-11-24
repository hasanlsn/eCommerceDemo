//
//  UICollectionViewExt.swift
//  eCommerceDemo
//
//  Created by Hasan Ali Asan on 23.11.2023.
//  Copyright © 2023 Hasan Ali Asan. All rights reserved.
//

import UIKit

extension UICollectionView {
    func registerCell(with cellClass: AnyClass) {
        self.register(cellClass, forCellWithReuseIdentifier: String(describing: cellClass.self))
    }
    
    func registerSupplementaryView(with viewClass: AnyClass, elementKind: String) {
        self.register(viewClass,
                      forSupplementaryViewOfKind: elementKind,
                      withReuseIdentifier: String(describing: viewClass.self))
    }
    
    func dequeueCell<T>(withClassAndIdentifier classAndIdentifier: T.Type, for indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withReuseIdentifier: String(describing: T.self), for: indexPath) as! T
    }
    
    func dequeueSupplementaryView<T>(with classAndIdentifier: T.Type,
                                     kind: String,
                                     for indexPath: IndexPath) -> T? {
        return self.dequeueReusableSupplementaryView(ofKind: kind,
                                                     withReuseIdentifier: String(describing: T.self),
                                                     for: indexPath) as? T
    }
}

extension UICollectionViewDiffableDataSource {
    func applySnapshot(_ snapshot: NSDiffableDataSourceSnapshot<SectionIdentifierType, ItemIdentifierType>,
                       animated: Bool,
                       completion: (() -> Void)? = nil) {
        if #available(iOS 15.0, *) {
            self.apply(snapshot, animatingDifferences: animated, completion: completion)
        } else {
            if animated {
                self.apply(snapshot, animatingDifferences: true, completion: completion)
            } else {
                UIView.performWithoutAnimation {
                    self.apply(snapshot, animatingDifferences: true, completion: completion)
                }
            }
        }
    }
}
