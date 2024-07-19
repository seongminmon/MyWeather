//
//  ForecastResponse.swift
//  MyWeather
//
//  Created by 김성민 on 7/15/24.
//

import Foundation

struct ForecastResponse: Decodable {
    let cod: String
    let message, cnt: Int
    let list: [List]
    let city: City
}

struct List: Decodable {
    let dt: Int
    let main: Main
    let weather: [Weather]
    let clouds: Clouds
    let wind: Wind
    let dtTxt: String   // "2024-07-15 12:00:00"

    enum CodingKeys: String, CodingKey {
        case dt, main, weather, clouds, wind
        case dtTxt = "dt_txt"
    }
}

struct Coord: Decodable {
    let lon, lat: Double
}

struct Weather: Decodable {
    let id: Int
    let main, description, icon: String
}

struct Main: Decodable {
    let temp, tempMin, tempMax: Double
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

struct Wind: Decodable {
    let speed: Double
    let deg: Int
}

struct City: Decodable {
    let id: Int
    let name: String
    let coord: Coord
    let country: String
}
