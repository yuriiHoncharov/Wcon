//
//  HomeBuilder.swift
//  WConnectUIKit
//
//  Created by Yurii Honcharov on 23.02.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

struct HomeBuilder {
    typealias Controller = HomeViewController
    typealias Presenter = HomePresenter
    
    func`default`() -> Controller {
        let vc = Controller.fromStoryboard
        let presenter = Presenter(view: vc)
        let worker = HomeWorker()
        let interactor = HomeInteractor(worker: worker, presenter: presenter)
        let router = HomeRouter(view: vc, interactor: interactor)
        
        vc.initialSetup(interactor: interactor, router: router)
        return vc
    }
}
