//
//  Times.swift
//  FinalProject
//
//  Created by Emma  Hopson on 10/24/23.
//

import Foundation

struct LocationTimes: Codable {
    var results: SunDetails
    var status: String
}

struct SunDetails: Codable{
    var sunrise: Date
    var sunset: Date
    var solar_noon: Date
    //var day_length: DateInterval
    var civil_twilight_begin: Date
    var civil_twilight_end: Date
    var nautical_twilight_begin: Date
    var nautical_twilight_end: Date
    var astronomical_twilight_begin: Date
    var astronomical_twilight_end: Date
}
