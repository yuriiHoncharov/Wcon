//
//  ServiceSearchV2Presenter.swift
//  WConnectUIKit
//
//  Created by Yurii Honcharov on 23.02.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.

import Foundation

protocol ServiceSearchV2PresenterProtocol {
    func configure(_ entities: [SearchEntity], dateUtility: DateFormatterUtility)
}

class ServiceSearchV2Presenter: ServiceSearchV2PresenterProtocol {
    private unowned let view: ServiceSearchV2ViewControllerProtocol
    
    required init(view: ServiceSearchV2ViewControllerProtocol) {
        self.view = view
    }
    
    func configure(_ entities: [SearchEntity], dateUtility: DateFormatterUtility) {
        var viewEntites: [ServiceSearchV2Entity.View.SearchItemEntity] = []
        for entity in entities {
     
            let viewEntity = ServiceSearchV2Entity.View.SearchItemEntity(id: entity.id,
                                                                         name: entity.firstName,
                                                                         surname: entity.lastName,
                                                                         category: entity.category,
                                                                         day: entity.day,
                                                                         isFavorite: entity.isFavorite,
                                                                         avatar: entity.avatar,
                                                                         comment: entity.comment)
//            let fullDate = dateUtility.date(from: entity.createdAt)
//            let date = dateUtility.dayMonthYear(from: fullDate)
//            let viewEntity = ServiceSearchV2Entity.View.SearchItemEntity(id: entity.id,
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
        
//        let categories = [entity.category?.titleTranslations?.localized(),
//                          entity.subcategory?.titleTranslations?.localized(),
//                          entity.clarification?.titleTranslations?.localized()].compactMap { $0 }
//        let images = entity.images.map {
//            ImageObject(id: $0.id,
//                        url: $0.url,
//                        contentType: $0.contentType)
//        }
//
//        let fullDate = dateUtility.date(from: entity.createdAt)
//        let date = dateUtility.dayMonthYear(from: fullDate)
//        let lastShotName = entity.specialist.lastName.prefix(1)
//        let promotionTypes: [TypePromotion] = entity.specialist.buyPromotion.map({ $0.type })
//
//        return SearchEntity(id: entity.id,
//                            number: nil,
//                            category: entity.category?.titleTranslations?.localized() ?? "",
//                            categories: categories,
//                            subcategory: entity.subcategory?.titleTranslations?.localized() ?? "",
//                            clarification: entity.clarification?.titleTranslations?.localized() ?? "",
//                            day: date,
//                            firstName: entity.specialist.firstName,
//                            lastName: isShowFullLastName ? entity.specialist.lastName : String(lastShotName),
//                            city: entity.specialist.city,
//                            district: entity.district,
//                            address: entity.address,
//                            gender: Gender(rawValue: entity.specialist.gender) ?? .unknown,
//                            birthday: entity.specialist.birthday ?? "",
//                            ageFrom: 1,
//                            ageTo: 2,
//                            comment: entity.comment,
//                            priceFrom: entity.priceFrom,
//                            priceTo: entity.priceTo,
//                            lastMessage: nil,
//                            avatar: entity.specialist.avatar ?? "",
//                            receiver: entity.specialist.id,
//                            isOnline: entity.specialist.isOnline,
//                            isPopular: entity.specialist.isPopular ?? false,
//                            images: images,
//                            isFavorite: entity.specialist.isFavorite ?? false,
//                            buyPromotions: promotionTypes)
    }
}
