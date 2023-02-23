//
//  ServiceSearchInteractor.swift
//  WConnectUIKit
//
//  Created by Yurii Honcharov on 23.02.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.

import Foundation

protocol ServiceSearchInteractorProtocol {
    func getData()
    
}

protocol ServiceSearchDataStore: AnyObject {
}

class ServiceSearchInteractor: ServiceSearchInteractorProtocol, ServiceSearchDataStore {
    private let presenter: ServiceSearchPresenterProtocol?
    private let worker: ServiceSearchWorkerProtocol?
    private let apiRequest = ServiceRequest()
    private var services: [SearchEntity] = []
    
    required init(worker: ServiceSearchWorkerProtocol, presenter: ServiceSearchPresenterProtocol) {
        self.worker = worker
        self.presenter = presenter
    }
    
    func getData() {
        getService { [weak self] data in
            guard let self else { return }
            self.services = data
            self.presenter?.configure(data, dateUtility: DateFormatterUtility())
        }
    }
    
    private func getService(completion: ((_ data: [SearchEntity]) -> Void)?) {
        let params = ServiceSearchApiEntity.Request(categories: [],
                                                    subcategories: [],
                                                    clarifications: [],
                                                    city: "",
                                                    district: "",
                                                    text: "",
                                                    page: 0)
        
        apiRequest.guestSearch(params: params) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                var specialists: [SearchEntity] = []
                
                switch result {
                case .success(let model):
                    let items = model.items ?? []
                    items.forEach { item in
                        let specialist = SearchEntityMapper.map(item, dateUtility: DateFormatterUtility())
                        specialists.append(specialist)
                    }
                    self.services.append(contentsOf: specialists)
                case .failure(let error):
                    print(error.localizedDescription)
                }
                
                completion?(specialists)
            }
        }
    }
}
