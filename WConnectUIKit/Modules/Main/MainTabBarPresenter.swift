//
//  MainTabBarPresenter.swift
//  Dogiz
//
//  Created by Yurii Honcharov on 23.02.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.

import Foundation

protocol MainTabBarPresenterProtocol {
}

class MainTabBarPresenter: MainTabBarPresenterProtocol {
    private unowned let view: MainTabBarControllerProtocol
    
    required init(view: MainTabBarControllerProtocol) {
        self.view = view
    }
}
