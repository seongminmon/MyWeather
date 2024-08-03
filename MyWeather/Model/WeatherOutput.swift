//
//  WeatherOutput.swift
//  MyWeather
//
//  Created by 김성민 on 7/19/24.
//

import Foundation

struct WeatherOutput {
    let cityName: String
    let temp: String
    let description: WeatherDescription
    let tempDescription: String
    
    let coord: Coord
    
    let wind: String
    let cloud: String
    let barometer: String
    let humidity: String
}

enum WeatherDescription: String, CaseIterable {
    case clear = "clear sky"
    case cloud1 = "few clouds"
    case cloud2 = "scattered clouds"
    case cloud3 = "broken clouds"
    case rain1 = "shower rain"
    case rain2 = "rain"
    case thunderstorm = "thunderstorm"
    case snow = "snow"
    case mist = "mist"
    
    var imageName: String {
        switch self {
        case .clear:
            "clear"
        case .cloud1, .cloud2, .cloud3:
            "cloud"
        case .rain1, .rain2:
            "rain"
        case .thunderstorm:
            "thunderstorm"
        case .snow:
            "snow"
        case .mist:
            "mist"
        }
    }
}
