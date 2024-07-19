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
