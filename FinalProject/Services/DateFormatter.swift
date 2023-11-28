//
//  DateFormatter.swift
//  FinalProject
//
//  Created by Emma  Hopson on 10/24/23.
//

import Foundation

public extension Date {
    var basicTimeString: String { return ISO8601DateFormatter().string(from: self) }
    var yearMonthDayTimeString: String { return DateFormatter.yearMonthDayTimeFormatter.string(from: self)}
}

public extension String {
    var basicTimeDate: Date? { return ISO8601DateFormatter().date(from: self) }
    var yearMonthDayTimeDate: Date? { return DateFormatter.yearMonthDayTimeFormatter.date(from: self)}
}

public extension DateFormatter {
    
    static let yearMonthDayTimeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = TimeZone.autoupdatingCurrent
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()

}
