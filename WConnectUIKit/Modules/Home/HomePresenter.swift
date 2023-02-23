//
//  HomePresenter.swift
//  WConnectUIKit
//
//  Created by Yurii Honcharov on 23.02.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.

import Foundation

protocol HomePresenterProtocol {
}

class HomePresenter: HomePresenterProtocol {
    private unowned let view: HomeViewControllerProtocol
    
    required init(view: HomeViewControllerProtocol) {
        self.view = view
    }
}
