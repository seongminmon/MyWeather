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
    var outputWeather: Observable<WeatherOutput?> = Observable(nil)
    var outputForeCastHourList: Observable<[ForecastOutput.Hour]> = Observable([])
    var outputForeCastDayList: Observable<[ForecastOutput.Day]> = Observable([])
    
    override func transform() {
        inputViewDidLoadTrigger.bind { [weak self] _ in
            guard let self else { return }
            callRequest()
        }
    }
    
    private func callRequest() {
        // 네트워크 통신 (도시 ID + 현재 날씨)
        NetworkManager.shared.request(api: .currentCityID(id: "1846266"), model: WeatherResponse.self) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let data):
                outputWeather.value = weatherResponseToOutput(data)
            case .failure(let error):
                print(error)
            }
        }
        
        // 네트워크 통신 (도시 ID + 예보)
        NetworkManager.shared.request(api: .forecastCityID(id: "1846266"), model: ForecastResponse.self) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let data):
                // 1. 3시간 간격의 일기예보
                outputForeCastHourList.value = forecastResponseToHour(data)
                // 2. 5일 간의 일기예보
                outputForeCastDayList.value = forecastResponseToDay(data)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func weatherResponseToOutput(_ data: WeatherResponse) -> WeatherOutput {
        let temp = data.main.temp.makeToString()
        let tempMin = data.main.tempMin.makeToString()
        let tempMax = data.main.tempMax.makeToString()
        
        return WeatherOutput(
            cityName: data.name,
            temp: " \(temp)°",
            description: data.weather.first!.description,
            tempDescription: "최고: \(tempMax)° | 최저: \(tempMin)°",
            wind: "\(data.wind.speed)m/s",
            cloud: "\(data.clouds.all)%",
            barometer: "\(data.main.pressure)hpa",
            humidity: "\(data.main.humidity)%"
        )
    }
    
    private func forecastResponseToHour(_ data: ForecastResponse) -> [ForecastOutput.Hour] {
        var ret = [ForecastOutput.Hour]()
        for item in data.list {
            let icon = item.weather.first?.icon ?? ""
            let url = URL(string: APIURL.iconURL + icon + "@2x.png")
            let hour = ForecastOutput.Hour(
                hour: item.hour,
                iconURL: url,
                temp: item.main.temp.makeToString() + "°"
            )
            ret.append(hour)
            
            // 3일간만 보여주기
            if ret.count >= 24 { break }
        }
        return ret
    }
    
    private func forecastResponseToDay(_ data: ForecastResponse) -> [ForecastOutput.Day] {
        return []
    }
    
//        dayLabel.text = "오늘"
//        iconImageView.image = UIImage(systemName: "sun.max")
//        minTempLabel.text = "최저 -2°"
//        maxTempLabel.text = "최고 9°"
    
//    var temp = Forecast(day: "", icon: "", minTemp: "", maxTemp: "")
//    for item in data.list {
//        // 날짜가 바뀌었다면 기존 temp 추가 후 전체 교체
//        if temp.day != item.day {
//            outputForcastList.value.append(temp)
//            temp = Forecast(
//                day: item.day,
//                icon: item.weather.first?.icon ?? "",
//                minTemp: item.main.tempMinCelsius,
//                maxTemp: item.main.tempMaxCelsius
//            )
//        } else {
//            // 같은 날짜이면 갱신하기
//            temp.minTemp =
//        }
//
//        // 종료 조건
//        if outputForcastList.value.count == 5 {
//            break
//        }
//    }
}
