//
//  DrawerViewController.swift
//  eCommerceDemo
//
//  Created by Hasan Ali Asan on 26.11.2023.
//

import UIKit
import PanModal

class DrawerViewController: UIViewController {
    // MARK: - IBOutlets -
    
    //
    
    // MARK: - Public Properties -
    
    var panScrollView: UIScrollView?
    var panContentHeight: CGFloat?
    
    //
    
    // MARK: - Private Properties -
    
    private lazy var childContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private var childControllers: [UIViewController]!
    private var childNavigationController: UINavigationController!
    
    //
    
    // MARK: - Object Lifecycle -
    
    init(childViewControllers: [UIViewController]) {
        super.init(nibName: nil, bundle: nil)
        
        self.childControllers = childViewControllers
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    //
    
    // MARK: - View Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.prepareViews()
    }
    
    //
    
    // MARK: - Helpers -
    
    private func prepareViews() {
        self.view.addSubview(self.childContainerView)
        
        self.childContainerView.snp.makeConstraints {
            $0.trailing.leading.top.bottom.equalToSuperview()
        }
        
        self.childNavigationController = UINavigationController()
        self.childNavigationController.viewControllers = self.childControllers
        self.childNavigationController.setNavigationBarHidden(true, animated: false)
        
        self.addWithView(self.childNavigationController,
                         to: self.childContainerView)
    }
    
    func layoutPanModal() {
        self.panModalSetNeedsLayoutUpdate()
        self.panModalTransition(to: .shortForm)
    }
    
    //
    
    // MARK: - Actions -
    
    //
}

// MARK: - PanModalPresentable -

extension DrawerViewController: PanModalPresentable {
    var panScrollable: UIScrollView? {
        return self.panScrollView
    }
    
    var showDragIndicator: Bool {
        return false
    }
    
    var shortFormHeight: PanModalHeight {
        guard let panContentHeight else {
            return .contentHeightIgnoringSafeArea(0)
        }
        
        return .contentHeight(panContentHeight)
    }
    
    var longFormHeight: PanModalHeight {
        return .maxHeightWithTopInset(0)
    }
}

//
