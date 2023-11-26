//
//  ProductInfoViewController.swift
//  eCommerceDemo
//
//  Created by Hasan Ali Asan on 25.11.2023.
//  Copyright (c) 2023 Hasan Ali Asan. All rights reserved.
//

import UIKit
import WebKit
import PanModal

protocol ProductInfoDisplayLogic: AnyObject {
    func displayProductInfo(viewModel: ProductInfo.Info.ViewModel)
}

final class ProductInfoViewController: BaseViewController {
    // MARK: - IBOutlets -
    
    //
    
    // MARK: - Public Properties -
    
    var interactor: ProductInfoBusinessLogic?
    var router: (NSObjectProtocol & ProductInfoRoutingLogic & ProductInfoDataPassing)?
    
    //
    
    // MARK: - Private Properties -
    
    private lazy var headerContainerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var dragIndicator: UIView = {
        let view = UIView()
        view.roundCorners(corners: .allCorners, radius: 3)
        view.backgroundColor = UIColor.colorCCCCCC
        return view
    }()
    
    private lazy var dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.colorF2F2F2
        return view
    }()
    
    private lazy var segmentedControl: PrimarySegmentedControl = {
        let segmentedControl = PrimarySegmentedControl(items: ["Ürün Bilgileri", "Diğer Bilgiler"])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self,
                                   action: #selector(self.handleSegmentChange(_:)),
                                   for: .valueChanged)
        return segmentedControl
    }()
    
    private lazy var webView: WKWebView = {
        let config = WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero, configuration: config)
        webView.navigationDelegate = self
        return webView
    }()
    
    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.isHidden = true
        return textView
    }()
    
    private var webViewContentHeight: CGFloat = 0
    
    //
    
    // MARK: - Object lifecycle -
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    //
    
    // MARK: - Setup -
    
    private func setup() {
        let viewController = self
        let interactor = ProductInfoInteractor()
        let presenter = ProductInfoPresenter()
        let router = ProductInfoRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    //
    
    // MARK: - View lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.prepareViews()
        
        self.interactor?.viewDidLoad()
    }
    
    //
    
    // MARK: - Helpers -
    
    private func prepareViews() {
        self.headerContainerView.addSubview(self.dragIndicator)
        self.headerContainerView.addSubview(self.segmentedControl)
        self.headerContainerView.addSubview(self.dividerView)
        self.view.addSubview(self.headerContainerView)
        self.view.addSubview(self.webView)
        self.view.addSubview(self.textView)
        
        self.headerContainerView.snp.makeConstraints {
            $0.trailing.leading.top.equalToSuperview()
        }
        
        self.dragIndicator.snp.makeConstraints {
            $0.width.equalTo(48)
            $0.height.equalTo(6)
            $0.top.equalToSuperview().offset(8)
            $0.centerX.equalToSuperview()
        }
        
        self.segmentedControl.snp.makeConstraints {
            $0.top.equalTo(self.dragIndicator.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().offset(-24)
            $0.height.equalTo(44)
        }
        
        self.dividerView.snp.makeConstraints {
            $0.top.equalTo(self.segmentedControl.snp.bottom)
            $0.leading.trailing.equalTo(self.segmentedControl)
            $0.bottom.equalToSuperview().offset(-16)
            $0.height.equalTo(1)
        }
        
        self.webView.snp.makeConstraints {
            $0.leading.trailing.equalTo(self.dividerView)
            $0.top.equalTo(self.headerContainerView.snp.bottom)
            $0.bottom.equalToSuperview().offset(-16)
        }
        
        self.textView.snp.makeConstraints {
            $0.leading.trailing.equalTo(self.dividerView)
            $0.top.equalTo(self.headerContainerView.snp.bottom)
            $0.bottom.greaterThanOrEqualToSuperview().offset(-16).priority(.low)
        }
    }
    
    //
    
    // MARK: - IBActions -
    
    @objc
    private func handleSegmentChange(_ sender: UISegmentedControl) {
        self.webView.isHidden = sender.selectedSegmentIndex != 0
        self.textView.isHidden = sender.selectedSegmentIndex != 1
        
        self.drawerPanSetNeedsLayout()
    }
    
    //
}

// MARK: - ProductInfoDisplayLogic -

extension ProductInfoViewController: ProductInfoDisplayLogic {
    func displayProductInfo(viewModel: ProductInfo.Info.ViewModel) {
        self.webView.loadHTMLString(viewModel.htmlContent, baseURL: nil)
        
        let attrText =
        NSMutableAttributedString()
            .bold("Ürün Kodu: ")
            .regular(viewModel.productCode + "\n", fontSize: 12)
            .bold("Marka: ")
            .regular(viewModel.brand + "\n", fontSize: 12)
            .bold("Menşei: ")
            .regular(viewModel.origin + "\n", fontSize: 12)
        
        self.textView.attributedText = attrText
    }
}

//

extension ProductInfoViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.evaluateJavaScript("document.readyState", completionHandler: { (complete, error) in
            if complete == nil {
                return
            }
            
            let script = """
var meta1 = document.createElement('meta');
meta1.setAttribute('http-equiv', 'X-UA-Compatible');
meta1.setAttribute('content', 'IE=Edge');
document.getElementsByTagName('head')[0].appendChild(meta1);

var meta2 = document.createElement('meta');
meta2.setAttribute('name', 'viewport');
meta2.setAttribute('content', 'width=device-width, initial-scale=1.0');
document.getElementsByTagName('head')[0].appendChild(meta2);

document.body.scrollHeight;
"""
            webView.evaluateJavaScript(script, completionHandler: { [weak self] (result, error) in
                if let height = result as? CGFloat {
                    self?.webViewContentHeight = height
                    
                    self?.drawerPanSetNeedsLayout()
                }
            })
        })
    }
}

extension ProductInfoViewController: DrawerPresentable {
    var panScrollView: UIScrollView? {
        return nil
    }
    
    var panContentHeight: CGFloat? {
        if self.webView.isHidden == false {
            return self.headerContainerView.bounds.size.height + self.webViewContentHeight + 16
        }
        
        if self.textView.isHidden == false {
            return self.headerContainerView.bounds.size.height + self.textView.frame.size.height
        }
        
        return nil
    }
}
