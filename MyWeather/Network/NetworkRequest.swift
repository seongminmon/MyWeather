//
//  NetworkRequest.swift
//  MyWeather
//
//  Created by 김성민 on 7/15/24.
//

import Foundation
import Alamofire

enum NetworkRequest {
    case currentCityID(id: String)
    case currentLocation(lat: String, lon: String)
    case forecastCityID(id: String)
    case forecastLocation(lat: String, lon: String)
    
    var baseURL: String {
        return APIURL.weatherURL
    }
    
    var endpoint: URL {
        switch self {
        case .currentCityID, .currentLocation:
            return URL(string: baseURL + "weather")!
        case .forecastCityID, .forecastLocation:
            return URL(string: baseURL + "forecast")!
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameters: Parameters {
        switch self {
        case .currentCityID(let id), .forecastCityID(let id):
            return [
                "id": id,
                "appid": APIKey.weatherKey
            ]
        case .currentLocation(let lat, let lon), .forecastLocation(let lat, let lon):
            return [
                "lat": lat,
                "lon": lon,
                "appid": APIKey.weatherKey
            ]
        }
    }
    
    var encoding: URLEncoding {
        return URLEncoding(destination: .queryString)
    }
}
