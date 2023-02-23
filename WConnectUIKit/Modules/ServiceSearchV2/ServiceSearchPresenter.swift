//
//  ServiceSearchPresenter.swift
//  WConnectUIKit
//
//  Created by Yurii Honcharov on 23.02.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.

import Foundation

protocol ServiceSearchPresenterProtocol {
    func configure(_ entities: [SearchEntity], dateUtility: DateFormatterUtility)
}

class ServiceSearchPresenter: ServiceSearchPresenterProtocol {
    private unowned let view: ServiceSearchViewControllerProtocol
    
    required init(view: ServiceSearchViewControllerProtocol) {
        self.view = view
    }
    
    func configure(_ entities: [SearchEntity], dateUtility: DateFormatterUtility) {
        var viewEntites: [ServiceSearchEntity.View.SearchItemEntity] = []
        for entity in entities {
     
            let viewEntity = ServiceSearchEntity.View.SearchItemEntity(id: entity.id,
                                                                         name: entity.firstName,
                                                                         surname: entity.lastName,
                                                                         category: entity.category,
                                                                         day: entity.day,
                                                                         isFavorite: entity.isFavorite,
                                                                         avatar: entity.avatar,
                                                                         comment: entity.comment)
//            let fullDate = dateUtility.date(from: entity.createdAt)
//            let date = dateUtility.dayMonthYear(from: fullDate)
//            let viewEntity = ServiceSearchEntity.View.SearchItemEntity(id: entity.id,
//                                                                         name: entity.specialist.firstName,
//                                                                         surname: entity.specialist.lastName,
//                                                                         category: entity.category?.titleTranslations?.localized() ?? "",
//                                                                         day: date,
//                                                                         isFavorite: entity.specialist.isFavorite ?? false,
//                                                                         avatar: entity.specialist.avatar ?? "",
//                                                                         comment: entity.comment)
            viewEntites.append(viewEntity)
        }
        
        view.configure(viewEntites)
    }
}
