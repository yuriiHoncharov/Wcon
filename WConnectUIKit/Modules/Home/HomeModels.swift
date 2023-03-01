//
//  HomeModels.swift
//  WConnectUIKit
//
//  Created by Yurii Honcharov on 23.02.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.

import Foundation

enum HomeEntity {
    struct Request: Codable {
        let page: Int?
        let limit: Int
    }
    
    struct Response: BaseResponseProtocol {
        var error: String?
        let items: [Category]?
        let totalCount: Int?
    }
    
    struct Category: Codable {
        let id: String?
        let remark: String?
        let titleTranslations: LocalizedApiTitle?
        let title: String?
        let icon: String?
        
        enum CodingKeys: String, CodingKey {
            case id = "_id"
            case remark
            case titleTranslations
            case title
            case icon
        }
    }
    
    struct View {
        struct CategoryEntity {
            var id: String
            var title: String
            var icon: String
        }
    }
}
