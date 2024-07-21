//
//  MainViewModel.swift
//  MyWeather
//
//  Created by 김성민 on 7/15/24.
//

import Foundation

final class MainViewModel: BaseViewModel {
    
    // Input
    var inputCityIDNetworkTrigger = Observable("")
    var inputCoordNetworkTrigger: Observable<Coord?> = Observable(nil)
    
    // Output
    var outputWeather: Observable<WeatherOutput?> = Observable(nil)
    var outputForeCastHourList: Observable<[ForecastOutput.Hour]> = Observable([])
    var outputForeCastDayList: Observable<[ForecastOutput.Day]> = Observable([])
    
    override func transform() {
        inputCityIDNetworkTrigger.bind { [weak self] value in
            guard let self else { return }
            callRequestWithCityID(value)
        }
        
        inputCoordNetworkTrigger.bind { [weak self] value in
            guard let self else { return }
            callRequestWithCoord(value)
        }
    }
    
    private func callRequestWithCityID(_ cityID: String) {
        // 네트워크 통신 (도시 ID + 현재 날씨)
        NetworkManager.shared.request(api: .currentCityID(id: cityID), model: WeatherResponse.self) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let data):
                outputWeather.value = weatherResponseToOutput(data)
            case .failure(let error):
                print(error)
            }
        }
        
        // 네트워크 통신 (도시 ID + 예보)
        NetworkManager.shared.request(api: .forecastCityID(id: cityID), model: ForecastResponse.self) { [weak self] result in
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
    
    private func callRequestWithCoord(_ coord: Coord?) {
        let coord = coord ?? Seoul.coord
        let lat = String(coord.lat)
        let lon = String(coord.lon)
        
        // 네트워크 통신 (도시 ID + 현재 날씨)
        NetworkManager.shared.request(api: .currentLocation(lat: lat, lon: lon), model: WeatherResponse.self) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let data):
                outputWeather.value = weatherResponseToOutput(data)
            case .failure(let error):
                print(error)
            }
        }
        
        // 네트워크 통신 (도시 ID + 예보)
        NetworkManager.shared.request(api: .forecastLocation(lat: lat, lon: lon), model: ForecastResponse.self) { [weak self] result in
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
            coord: data.coord,
            wind: "\(data.wind.speed)m/s",
            cloud: "\(data.clouds.all)%",
            barometer: "\(data.main.pressure)hpa",
            humidity: "\(data.main.humidity)%"
        )
    }
    
    private func forecastResponseToHour(_ data: ForecastResponse) -> [ForecastOutput.Hour] {
        var ret = [ForecastOutput.Hour]()
        
        // 3일간만 보여주기
        for i in 0..<24 {
            let item = data.list[i]
            let date = Format.stringToDate(item.dtTxt, dateFormat: "yyyy-MM-dd HH:mm:ss")
            let icon = item.weather.first?.icon ?? ""
            
            let value = ForecastOutput.Hour(
                hour: Format.dateToString(date, dateFormat: "HH") + "시",
                iconURL: URL(string: APIURL.iconURL + icon + "@2x.png"),
                temp: item.main.temp.makeToString() + "°"
            )
            ret.append(value)
        }
        return ret
    }
    
    private func forecastResponseToDay(_ data: ForecastResponse) -> [ForecastOutput.Day] {
        var ret = [ForecastOutput.Day]()
        
        // 00시 기준으로 나누기 (날짜별로)
        let splitList = data.list.split { item in
            let date = Format.stringToDate(item.dtTxt, dateFormat: "yyyy-MM-dd HH:mm:ss")
            let hour = Format.dateToString(date, dateFormat: "HH")
            return hour == "00"
        }
        
        // 5일간의 일기 예보
        for i in 0..<5 {
            var tempDay = ForecastOutput.Day(day: "", iconURL: nil, tempMin: "", tempMax: "")
            var Min = Double(Int.max)
            var Max = Double(Int.min)
            
            for item in splitList[i] {
                // 날짜
                let date = Format.stringToDate(item.dtTxt, dateFormat: "yyyy-MM-dd HH:mm:ss")
                let day = Format.dateToString(date, dateFormat: "E")
                tempDay.day = day
                
                // 아이콘은 21시 기준으로
                let hour = Format.dateToString(date, dateFormat: "HH")
                let icon = item.weather.first?.icon ?? ""
                if hour == "21" {
                    tempDay.iconURL = URL(string: APIURL.iconURL + icon + "@2x.png")
                }
                
                let temp = item.main.temp.makeToString() + "°"
                if Min > item.main.temp {
                    Min = item.main.temp
                    tempDay.tempMin = "최저 " + temp
                }
                if Max < item.main.temp {
                    Max = item.main.temp
                    tempDay.tempMax = "최고 " + temp
                }
            }
            if i == 0 { tempDay.day = "오늘" }
            ret.append(tempDay)
        }
        return ret
    }
}
