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

final class ProductInfoViewController: PanPresentableViewController {
    // MARK: - IBOutlets -
    
    //
    
    // MARK: - Public Properties -
    
    var interactor: ProductInfoBusinessLogic?
    var router: (NSObjectProtocol & ProductInfoRoutingLogic & ProductInfoDataPassing)?
    
    //
    
    // MARK: - Private Properties -
    
    private lazy var dragIndicator: UIView = {
        let view = UIView()
        view.roundCorners(radius: 3)
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
        self.view.addSubview(self.dragIndicator)
        self.view.addSubview(self.segmentedControl)
        self.view.addSubview(self.dividerView)
        self.view.addSubview(self.webView)
        self.view.addSubview(self.textView)
        
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
            $0.height.equalTo(1)
        }
        
        self.webView.snp.makeConstraints {
            $0.leading.trailing.equalTo(self.dividerView)
            $0.top.equalTo(self.dividerView.snp.bottom).offset(16)
            $0.bottom.equalToSuperview().offset(-16)
        }
        
        self.textView.snp.makeConstraints {
            $0.leading.trailing.equalTo(self.dividerView)
            $0.top.equalTo(self.dividerView.snp.bottom).offset(16)
            $0.bottom.greaterThanOrEqualToSuperview().offset(-16).priority(.low)
        }
    }
    
    //
    
    // MARK: - IBActions -
    
    @objc
    private func handleSegmentChange(_ sender: UISegmentedControl) {
        self.webView.isHidden = sender.selectedSegmentIndex != 0
        self.textView.isHidden = sender.selectedSegmentIndex != 1
        
        self.calculateContentHeight()
    }
    
    private func calculateContentHeight() {
        if self.webView.isHidden == false {
            self.contentHeight = 6 + 8 + 44 + 16 + 16 + self.webViewContentHeight
            return
        }
        
        if self.textView.isHidden == false {
            self.contentHeight = 6 + 8 + 44 + 16 + 16 + self.textView.frame.size.height
            return
        }
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
var body = document.getElementsByTagName('body')[0];
body.style.fontSize = "24px";
document.body.scrollHeight;
"""
            webView.evaluateJavaScript(script, completionHandler: { [weak self] (result, error) in
                if let height = result as? CGFloat {
                    self?.webViewContentHeight = height
                    
                    self?.calculateContentHeight()
                }
            })
        })
    }
}
