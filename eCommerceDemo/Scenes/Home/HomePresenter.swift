//
//  HomePresenter.swift
//  eCommerceDemo
//
//  Created by Hasan Ali Asan on 23.11.2023.
//  Copyright (c) 2023 Hasan Ali Asan. All rights reserved.
//

import Foundation

protocol HomePresentationLogic: AnyObject {
    func presentLoginUpdate(response: Home.User.Response)
}

final class HomePresenter {
    weak var viewController: HomeDisplayLogic?
}

// MARK: - HomePresentationLogic -

extension HomePresenter: HomePresentationLogic {
    func presentLoginUpdate(response: Home.User.Response) {
        let responseModel = response.responseModel
        let isLoggedIn = responseModel != nil
        let name = responseModel?.name ?? ""
        let surname = responseModel?.surname ?? ""
        let nameAndSurname = "\(name) \(surname)"
        let viewModel = Home.User.ViewModel(isLoggedIn: isLoggedIn,
                                            nameAndSurname: nameAndSurname)
        self.viewController?.displayLoginUpdate(viewModel: viewModel)
    }
}

//
