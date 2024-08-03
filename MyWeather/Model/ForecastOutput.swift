//
//  ForecastOutput.swift
//  MyWeather
//
//  Created by 김성민 on 7/19/24.
//

import Foundation

enum ForecastOutput {
    // 3시간 간격의 일기예보
    struct Hour {
        let hour: String
        let iconURL: URL?
        let temp: String
    }
    
    // 5일 간의 일기예보
    struct Day {
        var day: String
        var iconURL: URL?
        var tempMin: String
        var tempMax: String
    }
}
