//
//  DateFormaterUtility.swift
//  WConnectUIKit
//
//  Created by Yurii Honcharov on 20.02.2023.
//

import Foundation

struct DateFormatterUtility {
    private let isoDateFormatter = ISO8601DateFormatter()
    private var now: Date { Date() }
    
    func date(from serverString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return dateFormatter.date(from: serverString) ?? Date()
    }
    
    func hourMinutes(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: date)
    }
    
    func dayMonthYear(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter.string(from: date)
    }
}
