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
    let dtTxt: String

    enum CodingKeys: String, CodingKey {
        case dt, main, weather, clouds, wind
        case dtTxt = "dt_txt"
    }
}

struct City: Decodable {
    let id: Int
    let name: String
    let coord: Coord
    let country: String
//    let population, timezone, sunrise, sunset: Int
}

struct Wind: Decodable {
    let speed: Double
    let deg: Int
    let gust: Double
}
