//
//  UIIMageViewExt.swift
//  eCommerceDemo
//
//  Created by Hasan Ali Asan on 23.11.2023.
//  Copyright © 2023 Hasan Ali Asan. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    func loadImage(url: URL?) {
        self.kf.setImage(with: url)
    }
}
