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
    
    var hour: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        guard let date = formatter.date(from: dtTxt) else { return "" }
        formatter.dateFormat = "hh"
        let str = formatter.string(from: date)
        return str + "시"
    }
}

struct City: Decodable {
    let id: Int
    let name: String
    let coord: Coord
    let country: String
}
