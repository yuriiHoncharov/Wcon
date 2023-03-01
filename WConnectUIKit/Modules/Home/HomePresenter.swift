//
//  HomePresenter.swift
//  WConnectUIKit
//
//  Created by Yurii Honcharov on 23.02.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.

import Foundation

protocol HomePresenterProtocol {
    func configure(_ entities: [HomeEntity.View.CategoryEntity])
}

class HomePresenter: HomePresenterProtocol {
    private unowned let view: HomeViewControllerProtocol
    
    required init(view: HomeViewControllerProtocol) {
        self.view = view
    }
    
    func configure(_ entities: [HomeEntity.View.CategoryEntity]) {
        var viewEntities: [HomeEntity.View.CategoryEntity] = []
        for entity in entities {
            let viewEntity = HomeEntity.View.CategoryEntity(id: entity.id,
                                            title: entity.title,
                                            icon: entity.icon)
            viewEntities.append(viewEntity)
        }
        view.configure(viewEntities)
    }
}
