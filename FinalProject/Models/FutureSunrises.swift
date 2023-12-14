//
//  File.swift
//  FinalProject
//
//  Created by Emma  Hopson on 11/27/23.
//

import Foundation

struct FutureSunrises: Identifiable{
    var date: Date
    var sunrise: Date
    
    var id: Date {return date}
}
