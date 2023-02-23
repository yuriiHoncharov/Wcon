//
//  HomeRouter.swift
//  WConnectUIKit
//
//  Created by Yurii Honcharov on 23.02.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

protocol HomeRouterProtocol: AnyObject {
}

class HomeRouter: HomeRouterProtocol {
    private unowned let view: UIViewController
    private unowned let dataStore: HomeDataStore
    
    required init(view: UIViewController, interactor: HomeDataStore) {
        self.view = view
        self.dataStore = interactor
    }
}
