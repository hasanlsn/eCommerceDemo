//
//  ProductDetailViewController.swift
//  eCommerceDemo
//
//  Created by Hasan Ali Asan on 25.11.2023.
//  Copyright (c) 2023 Hasan Ali Asan. All rights reserved.
//

import UIKit

protocol ProductDetailDisplayLogic: AnyObject {
    func displayProductDetail(viewModel: ProductDetail.Detail.ViewModel)
}

final class ProductDetailViewController: UIViewController {
    // MARK: - IBOutlets -
    
    //
    
    // MARK: - Public Properties -
    
    var interactor: ProductDetailBusinessLogic?
    var router: (NSObjectProtocol & ProductDetailRoutingLogic & ProductDetailDataPassing)?
    
    //
    
    // MARK: - Private Properties -
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.registerCell(with: ImageCarouselCell.self)
        tableView.registerCell(with: ProductInfoCell.self)
        tableView.registerCell(with: ProductDetailOptionCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    private var sectionsData: [ProductDetailSections] = []
    
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
        let interactor = ProductDetailInteractor()
        let presenter = ProductDetailPresenter()
        let router = ProductDetailRouter()
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
        self.view.addSubview(self.tableView)
        
        self.tableView.snp.makeConstraints {
            $0.trailing.leading.top.bottom.equalToSuperview()
        }
    }
    
    //
    
    // MARK: - IBActions -
    
    //
}

// MARK: - ProductDetailDisplayLogic -

extension ProductDetailViewController: ProductDetailDisplayLogic {
    func displayProductDetail(viewModel: ProductDetail.Detail.ViewModel) {
        self.sectionsData = viewModel.data
        
        self.tableView.reloadData()
    }
}

//

extension ProductDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sectionsData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sectionsData[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = self.sectionsData[indexPath.section][indexPath.row]
        switch item {
        case .imageItem(let imageData):
            let cell = tableView.dequeueCell(withClassAndIdentifier: ImageCarouselCell.self, for: indexPath)
            cell.configure(images: imageData)
            return cell
        case .infoItem(let model):
            let cell = tableView.dequeueCell(withClassAndIdentifier: ProductInfoCell.self, for: indexPath)
            cell.configure(viewModel: model)
            return cell
        case .optionItem(let title, _):
            let cell = tableView.dequeueCell(withClassAndIdentifier: ProductDetailOptionCell.self, for: indexPath)
            cell.configure(title: title)
            return cell
        }
    }
}

extension ProductDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = self.sectionsData[indexPath.section][indexPath.row]
        switch item {
        case .optionItem(_, let optionType):
            switch optionType {
            case .info:
                self.router?.navigate(to: .info)
            case .nutritions:
                self.router?.navigate(to: .nutritions)
            }
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}
