//
//  ServiceSearchV2Router.swift
//  WConnectUIKit
//
//  Created by Yurii Honcharov on 23.02.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

protocol ServiceSearchV2RouterProtocol: AnyObject {
}

class ServiceSearchV2Router: ServiceSearchV2RouterProtocol {
    private unowned let view: UIViewController
    private unowned let dataStore: ServiceSearchV2DataStore
    
    required init(view: UIViewController, interactor: ServiceSearchV2DataStore) {
        self.view = view
        self.dataStore = interactor
    }
}
