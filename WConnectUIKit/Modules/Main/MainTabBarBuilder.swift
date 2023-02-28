//
//  MainTabBarBuilder.swift
//  Dogiz
//
//  Created by Yurii Honcharov on 23.02.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

struct MainTabBarBuilder {
    typealias Controller = MainTabBarController
    typealias Presenter = MainTabBarPresenter
    
    func`default`() -> Controller {
        let vc = Controller.fromStoryboard
        let presenter = Presenter(view: vc)
        let worker = MainTabBarWorker()
        let interactor = MainTabBarInteractor(worker: worker, presenter: presenter)
        let router = MainTabBarRouter(view: vc, interactor: interactor)
        
        vc.initialSetup(interactor: interactor, router: router)
        return vc
    }
}
