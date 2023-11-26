//
//  ProductNutritionsViewController.swift
//  eCommerceDemo
//
//  Created by Hasan Ali Asan on 26.11.2023.
//  Copyright (c) 2023 Hasan Ali Asan. All rights reserved.
//

import UIKit

protocol ProductNutritionsDisplayLogic: AnyObject {
    func displayNutritions(viewModel: ProductNutritions.List.ViewModel)
}

final class ProductNutritionsViewController: PanPresentableViewController {
    // MARK: - IBOutlets -
    
    //
    
    // MARK: - Public Properties -
    
    var interactor: ProductNutritionsBusinessLogic?
    var router: (NSObjectProtocol & ProductNutritionsRoutingLogic & ProductNutritionsDataPassing)?
    
    //
    
    // MARK: - Private Properties -
    
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
    
    private lazy var pageTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(.jostBold, size: 16)
        label.textColor = .color0551A0
        label.text = "Besin Değerleri"
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.registerCell(with: ProductNutritionItemCell.self)
        tableView.registerHeaderFooterView(with: ProductNutritionHeaderView.self)
        tableView.registerHeaderFooterView(with: ProductNutritionFooterView.self)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        return tableView
    }()
    
    private var nutritionsData: [ProductNutritions.List.ViewModel.Item] = []
    
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
        let interactor = ProductNutritionsInteractor()
        let presenter = ProductNutritionsPresenter()
        let router = ProductNutritionsRouter()
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.contentHeight = 6 + 8 + 44 + 16 + 16 + self.tableView.contentSize.height
    }
    
    //
    
    // MARK: - Helpers -
    
    private func prepareViews() {
        self.view.addSubview(self.dragIndicator)
        self.view.addSubview(self.pageTitleLabel)
        self.view.addSubview(self.dividerView)
        self.view.addSubview(self.tableView)
        
        self.dragIndicator.snp.makeConstraints {
            $0.width.equalTo(48)
            $0.height.equalTo(6)
            $0.top.equalToSuperview().offset(8)
            $0.centerX.equalToSuperview()
        }
        
        self.pageTitleLabel.snp.makeConstraints {
            $0.top.equalTo(self.dragIndicator.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().offset(-24)
        }
        
        self.dividerView.snp.makeConstraints {
            $0.top.equalTo(self.pageTitleLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalTo(self.pageTitleLabel)
            $0.height.equalTo(1)
        }
        
        self.tableView.snp.makeConstraints {
            $0.leading.trailing.equalTo(self.dividerView)
            $0.top.equalTo(self.dividerView.snp.bottom).offset(16)
            $0.bottom.equalToSuperview().offset(-16)
        }
    }
    
    //
    
    // MARK: - IBActions -
    
    //
}

// MARK: - ProductNutritionsDisplayLogic -

extension ProductNutritionsViewController: ProductNutritionsDisplayLogic {
    func displayNutritions(viewModel: ProductNutritions.List.ViewModel) {
        self.nutritionsData = viewModel.data
        
        self.tableView.reloadData()
    }
}

//

extension ProductNutritionsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.nutritionsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(withClassAndIdentifier: ProductNutritionItemCell.self, for: indexPath)
        let item = self.nutritionsData[indexPath.row]
        cell.configure(viewModel: item)
        return cell
    }
}

extension ProductNutritionsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueHeaderFooterView(with: ProductNutritionHeaderView.self)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = tableView.dequeueHeaderFooterView(with: ProductNutritionFooterView.self)
        return footerView
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
}
