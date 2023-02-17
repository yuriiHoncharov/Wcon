//
//  TitleTranslationType.swift
//  WConnect
//
//  Created by Yurii Honcharov on 24.05.2022.
//  Copyright © 2022 Lampa. All rights reserved.
//

import Foundation

struct LocalizedApiTitle: Codable, TranslationProtocol {
    var en: String?
    var ru: String?
    var tr: String?
}
