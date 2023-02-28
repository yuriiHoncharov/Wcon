//
//  MainTabBarWorker.swift
//  Dogiz
//
//  Created by Yurii Honcharov on 23.02.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.

import Foundation

/// In order not to unnecessarily complicate the Interactor and not to duplicate the details of the business logic, an additional Worker element can be used. In simple modules, it is not always needed, but in sufficiently loaded modules it allows you to remove some of the tasks from Interactor. For example, the logic of interaction with the database can be transferred to the worker, especially if the same queries to the database can be used in different modules. So use it for requests.
protocol MainTabBarWorkerProtocol: AnyObject {
    // MARK: - Requests
    
    // MARK: - Other logic
}

class MainTabBarWorker: MainTabBarWorkerProtocol {
    // MARK: - Variables
    
    // MARK: - Requests
    
    // MARK: - Other logic
}
