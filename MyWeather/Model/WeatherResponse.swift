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
    let visibility: Int
    let wind: Wind
    let clouds: Clouds
    let sys: Sys
    let timezone: Int
    let id: Int
    let name: String
    let cod: Int
//    let base: String
//    let dt: Int
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
}

struct Clouds: Decodable {
    let all: Int
}

struct Sys: Decodable {
    let country: String
}

//struct Wind: Decodable {
//    let speed: Double
//    let deg: Int
//}
