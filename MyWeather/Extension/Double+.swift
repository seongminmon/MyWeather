//
//  Double+.swift
//  MyWeather
//
//  Created by 김성민 on 7/19/24.
//

import Foundation

extension Double {
    func makeToString() -> String {
        return String(format: "%.1f", self - 273.15)
    }
}
