//
//  CategoriesApiEntity.swift
//  WConnect
//
//  Created by Maksym Yevtukhivskiy on 02.02.2022.
//  Copyright © 2022 Lampa. All rights reserved.
//

import Foundation

enum CategoriesApiEntity {
    struct Request: Encodable {
        let page: Int?
        let limit: Int
        
        init(page: Int?, limit: Int = 20) {
            self.page = page
            self.limit = limit
        }
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
}
