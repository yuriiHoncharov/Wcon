//
//  HomeRouter.swift
//  WConnectUIKit
//
//  Created by Yurii Honcharov on 23.02.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

protocol HomeRouterProtocol: AnyObject {
   func navigationToServiceSearch()
   func navigateTo()
}

class HomeRouter: HomeRouterProtocol {
    private unowned let view: UIViewController
    private unowned let dataStore: HomeDataStore
    
    required init(view: UIViewController, interactor: HomeDataStore) {
        self.view = view
        self.dataStore = interactor
    }
    
    func navigateTo() {
        var navigationVC: UINavigationController
        var vc: UIViewController
        vc = ServiceSearchViewController()

        navigationVC = UINavigationController(rootViewController: vc)
        navigationVC.navigationBar.isHidden = true
        navigationVC.modalPresentationStyle = .fullScreen
        
        DispatchQueue.main.async {
            self.view.present(navigationVC, animated: true, completion: nil)
        }
    }
    
    func navigationToServiceSearch() {
        DispatchQueue.main.async { [weak self] in
            guard let `self` = self else { return }
            let vc = ServiceSearchViewController.builder.default()
            self.view.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
