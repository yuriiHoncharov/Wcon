//
//  ServiceSearchV2Builder.swift
//  WConnectUIKit
//
//  Created by Yurii Honcharov on 23.02.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

struct ServiceSearchV2Builder {
    typealias Controller = ServiceSearchV2ViewController
    typealias Presenter = ServiceSearchV2Presenter
    
    func`default`() -> Controller {
        let vc = Controller.fromStoryboard
        let presenter = Presenter(view: vc)
        let worker = ServiceSearchV2Worker()
        let interactor = ServiceSearchV2Interactor(worker: worker, presenter: presenter)
        let router = ServiceSearchV2Router(view: vc, interactor: interactor)
        
        vc.initialSetup(interactor: interactor, router: router)
        return vc
    }
}
