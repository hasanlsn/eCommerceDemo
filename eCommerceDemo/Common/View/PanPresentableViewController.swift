//
//  PanPresentableViewController.swift
//  eCommerceDemo
//
//  Created by Hasan Ali Asan on 25.11.2023.
//  Copyright © 2023 Hasan Ali Asan. All rights reserved.
//

import UIKit
import PanModal

class PanPresentableViewController: BaseViewController {
    var contentHeight: CGFloat? {
        didSet {
            self.panModalSetNeedsLayoutUpdate()
            self.panModalTransition(to: .shortForm)
        }
    }
    
    var panScrollView: UIScrollView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension PanPresentableViewController: PanModalPresentable {
    var panScrollable: UIScrollView? {
        return self.panScrollView
    }
    
    var showDragIndicator: Bool {
        return false
    }
    
    var shortFormHeight: PanModalHeight {
        if let contentHeight = self.contentHeight {
            return .contentHeight(contentHeight)
        }
        
        return .contentHeightIgnoringSafeArea(0)
    }
}
