//
//  NetworkManager.swift
//  MyWeather
//
//  Created by 김성민 on 7/15/24.
//

import Foundation
import Alamofire

final class NetworkManager {
    
    // 싱글톤으로 생성
    static let shared = NetworkManager()
    private init() {}
    
    func request<T: Decodable>(
        api: NetworkRequest,
        model: T.Type,
        completionHandler: @escaping (
            Result<T, Error>) -> Void
    ) {
        AF.request(api.endpoint,
                   method: api.method,
                   parameters: api.parameters,
                   encoding: api.encoding)
        .validate(statusCode: 200..<500)
        .responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let value):
                print("SUCCESS")
                completionHandler(.success(value))
                
            case .failure(let error):
                print(error)
                completionHandler(.failure(error))
            }
        }
    }
}
