//
//  GetServiceApiEntity.swift
//  WConnect
//
//  Created by Oleksii Kalinchuk on 18.04.2022.
//  Copyright © 2022 Lampa. All rights reserved.
//

import Foundation
import UIKit

enum ServiceSearchApiEntity {
    struct Request: Encodable {
        let categories: [String]?
        let subcategories: [String]?
        let clarifications: [String]?
        let city: String?
        let district: String?
        let text: String?
        let page: Int?
        let limit: Int = 50
    }
    
    struct Response: BaseResponseProtocol {
        var error: String?
        let items: [Item]?
        let totalCount: Int?
    }
    
    struct Item: Codable {
        let id: String
        let district: String
        let comment: String
        let address: String
        let priceFrom: Int
        let priceTo: Int
        let schedule: [Schedule]
        let images: [ImageApiEntity]
        let createdAt: String
        let updatedAt: String
        let category: Category?
        let subcategory: Subcategory?
        let clarification: Clarification?
        let specialist: Specialist
        
        enum CodingKeys: String, CodingKey {
            case id = "_id"
            case district
            case comment
            case address
            case priceFrom
            case priceTo
            case schedule
            case images
            case createdAt
            case updatedAt
            case category
            case subcategory
            case clarification
            case specialist
        }
                
        struct Category: Codable {
            let id: String
            let remark: String?
            let title: String?
            let name: String?
            let titleTranslations: LocalizedApiTitle?
            
            enum CodingKeys: String, CodingKey {
                case id = "_id"
                case remark
                case title
                case name
                case titleTranslations
            }
        }
        
        struct Subcategory: Codable {
            let id: String
            let title: String?
            let name: String?
            let titleTranslations: LocalizedApiTitle?
            let category: String?
            let remark: String?
            
            enum CodingKeys: String, CodingKey {
                case id = "_id"
                case title
                case name
                case titleTranslations
                case category
                case remark
            }
        }
        
        struct Clarification: Codable {
            let id: String
            let subcategory: String
            let remark: String
            let titleTranslations: LocalizedApiTitle?
            let title: String?
            let name: String?
            
            enum CodingKeys: String, CodingKey {
                case id = "_id"
                case title
                case name
                case titleTranslations
                case subcategory
                case remark
            }
        }
        
        struct Schedule: Codable {
            let day: DayOfWeek
            let workingHours: [WorkingHour]
            
            struct WorkingHour: Codable {
                let timeFrom: String
                let timeTo: String
            }
        }
        
        struct Specialist: Codable {
            let id: String
            let isPopular: Bool?
            let isFavorite: Bool?
            let rating: Double
            let firstName: String
            let lastName: String
            let city: String
            let phone: Phone?
            let birthday: String?
            let email: String
            let gender: String
            let createdAt: String
            let isOnline: Bool
            let avatar: String?
            let feedbackCount: Int
            let completedOrders: Int
            let buyPromotion: [Promotion]
            
            enum CodingKeys: String, CodingKey {
                case id = "_id"
                case isPopular = "popular"
                case isFavorite
                case rating
                case firstName
                case lastName
                case city
                case phone
                case birthday
                case email
                case gender
                case createdAt
                case isOnline
                case avatar
                case feedbackCount
                case completedOrders
                case buyPromotion
            }
        }
        
        struct Promotion: Codable {
            let type: TypePromotion
        }
        
        struct Phone: Codable {
            let number: String?
            let flag: String?
            let isoCode: String?
            let dialCode: String?
        }
    }
}


struct ImageApiEntity: Codable {
    let id: String
    let url: String
    let contentType: String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case url
        case contentType
    }
}

enum DayOfWeek: String, CaseIterable, Codable {
    case monday = "MONDAY"
    case tuesday = "TUESDAY"
    case wednesday = "WEDNESDAY"
    case thursday = "THURSDAY"
    case friday = "FRIDAY"
    case saturday = "SATURDAY"
    case sunday = "SUNDAY"
    
    var fullTitle: String {
        switch self {
        case .monday: return "monday"
        case .tuesday: return "tuesday"
        case .wednesday: return "wednesday"
        case .thursday: return "thursday"
        case .friday: return "friday"
        case .saturday: return "saturday"
        case .sunday: return "sunday"
        }
    }
}

enum TypePromotion: String, CaseIterable, Codable {
    case topCategory = "TOP_CATEGORY"
    case top = "TOP"
    case beautyName = "BEAUTY_NAME"
    case buyContact = "BUY_CONTACT"
}
