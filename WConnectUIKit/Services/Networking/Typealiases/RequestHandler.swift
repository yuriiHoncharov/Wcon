//
//  RequestHandler.swift
//  WConnect
//
//  Created by Dmytro Tarasovskyi on 23.05.2022.
//  Copyright © 2022 Lampa. All rights reserved.
//

import Foundation

typealias RequestHandler<T> = ((Result<T, HTTPClientError>) -> Void)
