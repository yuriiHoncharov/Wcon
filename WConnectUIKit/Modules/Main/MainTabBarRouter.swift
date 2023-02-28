//
//  MainTabBarRouter.swift
//  Dogiz
//
//  Created by Yurii Honcharov on 23.02.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

protocol MainTabBarRouterProtocol: AnyObject {
}

class MainTabBarRouter: MainTabBarRouterProtocol {
    private unowned let view: UIViewController
    private unowned let dataStore: MainTabBarDataStore
    
    required init(view: UIViewController, interactor: MainTabBarDataStore) {
        self.view = view
        self.dataStore = interactor
    }
}
