//
//  ServiceSearchMapper.swift
//  WConnectUIKit
//
//  Created by Yurii Honcharov on 20.02.2023.
//

import UIKit

struct SearchEntityMapper {
    static func map(_ entity: ServiceSearchApiEntity.Item, isShowFullLastName: Bool = true, dateUtility: DateFormatterUtility) -> SearchEntity {
        let categories = [entity.category?.titleTranslations?.localized(),
                          entity.subcategory?.titleTranslations?.localized(),
                          entity.clarification?.titleTranslations?.localized()].compactMap { $0 }
        let images = entity.images.map {
            ImageObject(id: $0.id,
                        url: $0.url,
                        contentType: $0.contentType)
        }
        
        let fullDate = dateUtility.date(from: entity.createdAt)
        let date = dateUtility.dayMonthYear(from: fullDate)
        let lastShotName = entity.specialist.lastName.prefix(1)
        let promotionTypes: [TypePromotion] = entity.specialist.buyPromotion.map({ $0.type })
        
        return SearchEntity(id: entity.id,
                            category: entity.category?.titleTranslations?.localized() ?? "",
                            categories: categories,
                            subcategory: entity.subcategory?.titleTranslations?.localized() ?? "",
                            clarification: entity.clarification?.titleTranslations?.localized() ?? "",
                            day: date,
                            firstName: entity.specialist.firstName,
                            lastName: isShowFullLastName ? entity.specialist.lastName : String(lastShotName),
                            city: entity.specialist.city,
                            district: entity.district,
                            address: entity.address,
                            gender: Gender(rawValue: entity.specialist.gender) ?? .unknown,
                            birthday: entity.specialist.birthday ?? "",
                            comment: entity.comment,
                            priceFrom: entity.priceFrom,
                            priceTo: entity.priceTo,
                            avatar: entity.specialist.avatar ?? "",
                            receiver: entity.specialist.id,
                            isOnline: entity.specialist.isOnline,
                            isPopular: entity.specialist.isPopular ?? false,
                            images: images,
                            isFavorite: entity.specialist.isFavorite ?? false,
                            buyPromotions: promotionTypes)
    }
}
