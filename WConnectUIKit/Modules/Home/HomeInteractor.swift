//
//  HomeInteractor.swift
//  WConnectUIKit
//
//  Created by Yurii Honcharov on 23.02.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.

import Foundation

protocol HomeInteractorProtocol {
    
}

protocol HomeDataStore: AnyObject {
}

class HomeInteractor: HomeInteractorProtocol, HomeDataStore {
    private let presenter: HomePresenterProtocol?
    private let worker: HomeWorkerProtocol?
    
    required init(worker: HomeWorkerProtocol, presenter: HomePresenterProtocol) {
        self.worker = worker
        self.presenter = presenter
    }
}
