//
//  MainTabBarInteractor.swift
//  Dogiz
//
//  Created by Yurii Honcharov on 23.02.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.

import Foundation

protocol MainTabBarInteractorProtocol {
    
}

protocol MainTabBarDataStore: AnyObject {
}

class MainTabBarInteractor: MainTabBarInteractorProtocol, MainTabBarDataStore {
    private let presenter: MainTabBarPresenterProtocol?
    private let worker: MainTabBarWorkerProtocol?
    
    required init(worker: MainTabBarWorkerProtocol, presenter: MainTabBarPresenterProtocol) {
        self.worker = worker
        self.presenter = presenter
    }
}
