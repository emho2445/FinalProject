//
//  DateFormatter.swift
//  FinalProject
//
//  Created by Emma  Hopson on 10/24/23.
//

import Foundation

public extension Date {
    var hourMinuteSecString: String { return DateFormatter.hourMinuteSecFormatter.string(from: self) }
    var basicTimeString: String { return DateFormatter.basicTimeFormatter.string(from: self) }
}

public extension String {
    var hourMinuteSecDate: Date? { return DateFormatter.hourMinuteSecFormatter.date(from: self) }
    var basicTimeString: Date? { return DateFormatter.basicTimeFormatter.date(from: self) }
}

public extension DateFormatter {
    
    // Mark: Internal formatters.
    
    static let hourMinuteSecFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-DDTHH:mm:ss+hh:mm"
        formatter.timeZone = TimeZone.autoupdatingCurrent
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
    
    static let basicTimeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-DDTHH:mm:ss+hh:mm"
        formatter.timeZone = TimeZone.autoupdatingCurrent
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
}
