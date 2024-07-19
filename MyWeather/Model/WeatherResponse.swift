//
//  WeatherResponse.swift
//  MyWeather
//
//  Created by 김성민 on 7/15/24.
//

import Foundation

struct WeatherResponse: Decodable {
    let coord: Coord
    let weather: [Weather]
    let main: Main
    let wind: Wind
    let clouds: Clouds
    let sys: Sys
    let id: Int
    let name: String
    let cod: Int
}

struct Coord: Decodable {
    let lon, lat: Double
}

struct Weather: Decodable {
    let id: Int
    let main, description, icon: String
}

struct Main: Decodable {
    // 현재 온도, 최고 온도, 최저 온도
    let temp, tempMin, tempMax: Double
    // 기압, 습도
    let pressure, humidity: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case humidity
    }
    
    var tempCelsius: String {
        return String(format: "%.1f", temp - 273.15)
    }
    
    var tempMinCelsius: String {
        return String(format: "%.1f", tempMin - 273.15)
    }
    
    var tempMaxCelsius: String {
        return String(format: "%.1f", tempMax - 273.15)
    }
}

struct Clouds: Decodable {
    let all: Int
}

struct Sys: Decodable {
    let country: String
}

struct Wind: Decodable {
    let speed: Double
    let deg: Int
}
