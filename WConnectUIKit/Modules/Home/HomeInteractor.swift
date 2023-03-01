//
//  HomeInteractor.swift
//  WConnectUIKit
//
//  Created by Yurii Honcharov on 23.02.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.

import Foundation

protocol HomeInteractorProtocol {
    func getData()
}

protocol HomeDataStore: AnyObject {
}

class HomeInteractor: HomeInteractorProtocol, HomeDataStore {
    private let presenter: HomePresenterProtocol?
    private let worker: HomeWorkerProtocol?
    private let categoryApi = CategoryRequest()
    private var categories: [HomeEntity.View.CategoryEntity] = []

    required init(worker: HomeWorkerProtocol, presenter: HomePresenterProtocol) {
        self.worker = worker
        self.presenter = presenter
    }
    
    func getData() {
        getCategories { [weak self] item in
            guard let self else { return }
            self.categories = item

        }
    }
    
  private func getCategories(completionHandler: ((_ item: [HomeEntity.View.CategoryEntity]) -> Void)? ) {
        
      categoryApi.getAllCategories(params: HomeEntity.Request(page: 0, limit: 20)) { [weak self] response in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                var categoryArray: [HomeEntity.View.CategoryEntity] = []

                switch response {
                case .success(let model):
                    if let error = model.error {
                        print(error)
                    } else {
                        
                        for item in model.items ?? [] {
                            guard let id = item.id, let title = item.titleTranslations?.localized(), let icon = item.icon else { continue }
                            
                            let newItem = HomeEntity.View.CategoryEntity(id: id, title: title, icon: icon)
                            categoryArray.append(newItem)
                        }
                        self.categories = categoryArray
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
                completionHandler?(categoryArray)
            }
        }
    }
}
