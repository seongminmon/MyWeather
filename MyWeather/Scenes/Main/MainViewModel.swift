//
//  MainViewModel.swift
//  MyWeather
//
//  Created by 김성민 on 7/15/24.
//

import Foundation

final class MainViewModel: BaseViewModel {
    
    // Input
    var inputViewDidLoadTrigger: Observable<Void?> = Observable(nil)
    
    // Output
    var outputWeatherResponse: Observable<WeatherResponse?> = Observable(nil)
    var outputForecastResponse: Observable<ForecastResponse?> = Observable(nil)
    
    override func transform() {
        inputViewDidLoadTrigger.bind { [weak self] value in
            guard let self, value != nil else { return }
            callRequest()
        }
    }
    
    private func callRequest() {
        // 네트워크 통신 (현재 날씨, 도시 ID)
        NetworkManager.shared.request(api: .currentCityID(id: "1846266"), model: WeatherResponse.self) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let data):
                outputWeatherResponse.value = data
            case .failure(let error):
                print(error)
            }
        }
        
        // 네트워크 통신 (예보, 도시 ID)
        NetworkManager.shared.request(api: .forecastCityID(id: "1846266"), model: ForecastResponse.self) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let data):
                outputForecastResponse.value = data
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
