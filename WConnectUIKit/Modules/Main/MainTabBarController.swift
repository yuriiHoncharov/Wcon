//
//  MainTabBarController.swift
//  Dogiz
//
//  Created by Yurii Honcharov on 23.02.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

protocol MainTabBarControllerProtocol: AnyObject {
    
}

class MainTabBarController: UITabBarController {
    // MARK: - IBOutlets
    
    // MARK: - Properties
    static let builder = MainTabBarBuilder()
    private var interactor: MainTabBarInteractorProtocol!
    private var router: MainTabBarRouterProtocol!
    
    // MARK: - Setup
    func initialSetup(interactor: MainTabBarInteractorProtocol, router: MainTabBarRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarController()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
        
    private func setupTabBarController() {
        setupTabBar()
        
        self.viewControllers = MainTabBarItems.allCases.map { return setupTabBarControllers($0) }
    }
    
    private func setupTabBarControllers(_ item: MainTabBarItems) -> UIViewController {
        let vc = item.viewController
        let tabBarItem = UITabBarItem(title: item.title,
                                      image: item.image,
                                      selectedImage: item.selectedImage)
        tabBarItem.tag = item.rawValue
        vc.tabBarItem = tabBarItem
        return vc
    }
    
    private func setupTabBar() {
        self.tabBar.roundCorners([.layerMinXMinYCorner, .layerMaxXMinYCorner], radius: 24)
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(named: Color.neutralGrey30) ?? .gray], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(named: Color.primeryGreen100) ?? .green], for: .selected)
    }
}

extension MainTabBarController: MainTabBarControllerProtocol {
    
}
