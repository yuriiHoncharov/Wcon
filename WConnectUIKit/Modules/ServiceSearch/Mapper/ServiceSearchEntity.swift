//
//  ServiceSearchEntity.swift
//  WConnectUIKit
//
//  Created by Yurii Honcharov on 20.02.2023.
//

import Foundation

enum Gender: String, CaseIterable, Codable {
    case male = "MALE"
    case female = "FEMALE"
    case unknown = "PREFER_NOT_TO_TELL"
}

struct ImageObject: Hashable {
    let id: String
    let url: String
    let contentType: String
}

struct SearchEntity: Identifiable, Hashable {
    let id: String
    let category: String
    let categories: [String]
    let subcategory: String
    let clarification: String
    let day: String
    let firstName: String
    let lastName: String
    let city: String
    let district: String
    let address: String
    let gender: Gender
    let birthday: String
    let comment: String
    let priceFrom: Int
    let priceTo: Int
    let avatar: String
    let receiver: String
    let isOnline: Bool
    let isPopular: Bool
    let images: [ImageObject]
    var isFavorite: Bool
    var buyPromotions: [TypePromotion]?
  
}

extension SearchEntity {
    static let mock = SearchEntity(id: "id" ,
                                   category: "category",
                                   categories: [],
                                   subcategory: "subcategory",
                                   clarification: "clarification",
                                   day: "day",
                                   firstName: "firstName",
                                   lastName: "lastName",
                                   city: "",
                                   district: "",
                                   address: "",
                                   gender: .male,
                                   birthday: "",
                                   comment: "comment",
                                   priceFrom: 1,
                                   priceTo: 2,
                                   avatar: "",
                                   receiver: "",
                                   isOnline: true,
                                   isPopular: true,
                                   images: [],
                                   isFavorite: true,
                                   buyPromotions: [])
}
