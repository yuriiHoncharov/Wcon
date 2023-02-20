//
//  BlogsApiEntity.swift
//  WConnectUIKit
//
//  Created by Yurii Honcharov on 16.02.2023.
//

import Foundation

enum BlogsApiEntity {
    struct Request: Encodable {
        let category: String
        let text: String
        let page: Int?
        let limit: Int = 20
    }
    
    struct Response: BaseResponseProtocol {
        var error: String?
        let items: [Item]?
        let totalCount: Int?
        let countByText: Int?
    }
    
    struct Item: Codable {
        let id: String?
        let category: Category?
        let image: String?
        let title: LocalizedApiTitle?
        let text: LocalizedApiTitle?
        let createdAt: String?
        let updatedAt: String?
        let creator: Creator?
        let popularity: Int?
        let webLink: String?
        
        enum CodingKeys: String, CodingKey {
            case id = "_id"
            case category, image, title, text, createdAt, updatedAt, creator, popularity, webLink
        }
    }
    struct Creator: Codable {
        let firstName: String?
        let lastName: String?
        let role: Role?
    }
    
    struct Category: Codable {
        let id: String?
        let remark: String?
        let titleTranslations: LocalizedApiTitle?
        let icon: String?
        let isDeleted: Bool?
        
        enum CodingKeys: String, CodingKey {
            case id = "_id"
            case remark, titleTranslations, icon, isDeleted
        }
    }
}

enum Role: String, Codable {
    case specialist = "SPECIALIST"
    case customer = "CUSTOMER"
    case admin = "ADMIN"
    case undefined = "EMPTY"
    
    var title: String {
        switch self {
        case .specialist: return "specialist"
        case .customer: return "customer"
        case .admin: return "admin"
        case .undefined: return "guest"
        }
    }
}

