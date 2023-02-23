//
//  RefreshTokenApiEntity.swift
//  WConnect
//
//  Created by Maksym Yevtukhivskiy on 21.03.2022.
//  Copyright © 2022 Lampa. All rights reserved.
//

import Foundation

enum RefreshTokenApiEntity {
    struct Request: Encodable {
        let token: String
    }
    
    struct Response: BaseResponseProtocol, TokenResponseProtocol {
        var error: String?
        
        var token: String?
        var refreshToken: String?
        var expirationDate: String?
        let role: Role?
        
        enum CodingKeys: String, CodingKey {
            case error
            case token
            case refreshToken
            case expirationDate = "expiration_date"
            case role
        }
    }
}
