//
//  ServiceSearchRouter.swift
//  WConnectUIKit
//
//  Created by Yurii Honcharov on 23.02.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

protocol ServiceSearchRouterProtocol: AnyObject {
}

class ServiceSearchRouter: ServiceSearchRouterProtocol {
    private unowned let view: UIViewController
    private unowned let dataStore: ServiceSearchDataStore
    
    required init(view: UIViewController, interactor: ServiceSearchDataStore) {
        self.view = view
        self.dataStore = interactor
    }
}
