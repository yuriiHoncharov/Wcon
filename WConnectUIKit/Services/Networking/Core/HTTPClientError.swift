//
//  HTTPClientError.swift
//  WConnectUIKit
//
//  Created by Yurii Honcharov on 16.02.2023.
//

import Foundation

enum HTTPClientError: Error, Equatable {
    case emptyURL(message: String)
    case authProblem(message: String)
    case responseStatusError(message: String)
    case serverError(message: String)
    case parseDataProblem(message: String)
    case absentInternetConnection(message: String)
    case requestAlreadyInQueue
    case userIsBanned
    case chatIsExist(message: String?)
    case userIsDeleted
}

extension HTTPClientError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case let .responseStatusError(message):
            return "\(message)"
        case let .emptyURL(message):
            return "\(message)"
        case let .authProblem(message):
            return "\(message)"
        case let .serverError(message):
            return "\(message)"
        case let .parseDataProblem(message):
            return "\(message)"
        case let .absentInternetConnection(message):
            return "\(message)"
        case .requestAlreadyInQueue:
            return nil
        case .userIsBanned:
            return "Error user is banned"
        case let .chatIsExist(message):
            return message ?? ""
        case .userIsDeleted:
            return "Error user is deleted"
        }
    }
}
