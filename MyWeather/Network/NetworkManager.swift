//
//  NetworkManager.swift
//  MyWeather
//
//  Created by 김성민 on 7/15/24.
//

import Foundation
import Alamofire

final class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    func request<T: Decodable>(
        api: NetworkRequest,
        model: T.Type,
        completionHandler: @escaping (Result<T, AFError>) -> Void
    ) {
        AF.request(
            api.endpoint,
            method: api.method,
            parameters: api.parameters,
            encoding: api.encoding
        )
        .validate(statusCode: 200..<500)
        .responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let value):
                completionHandler(.success(value))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
