//
//  ServiceSearchBuilder.swift
//  WConnectUIKit
//
//  Created by Yurii Honcharov on 23.02.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

struct ServiceSearchBuilder {
    typealias Controller = ServiceSearchViewController
    typealias Presenter = ServiceSearchPresenter
    
    func`default`() -> Controller {
        let vc = Controller.fromStoryboard
        let presenter = Presenter(view: vc)
        let worker = ServiceSearchWorker()
        let interactor = ServiceSearchInteractor(worker: worker, presenter: presenter)
        let router = ServiceSearchRouter(view: vc, interactor: interactor)
        
        vc.initialSetup(interactor: interactor, router: router)
        return vc
    }
}
