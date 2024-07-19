//
//  Format.swift
//  MyWeather
//
//  Created by 김성민 on 7/19/24.
//

import Foundation

enum Format {
    static let formatter = DateFormatter()
    
    static func stringToDate(_ str: String, dateFormat: String) -> Date {
        formatter.dateFormat = dateFormat
        return formatter.date(from: str) ?? Date()
    }
    
    static func dateToString(_ date: Date, dateFormat: String) -> String {
        formatter.dateFormat = dateFormat
        return formatter.string(from: date)
    }
}
