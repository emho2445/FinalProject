//
//  DateFormatter.swift
//  FinalProject
//
//  Created by Emma  Hopson on 10/24/23.
//

import Foundation

public extension Date {
    var basicTimeString: String { return ISO8601DateFormatter().string(from: self) }
}

public extension String {
    var basicTimeDate: Date? { return ISO8601DateFormatter().date(from: self) }
}
