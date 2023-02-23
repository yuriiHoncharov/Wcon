//
//  ServiceSearchModels.swift
//  WConnectUIKit
//
//  Created by Yurii Honcharov on 23.02.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.

import Foundation

enum ServiceSearchEntity {
    struct Request {
        
    }
    struct Response {
        
    }
    struct View {
        struct SearchItemEntity {
            var id: String
            var name: String
            var surname: String
            var category: String
            var day: String
            var isFavorite: Bool
            var avatar: String
            var comment: String
        }
    }
}
