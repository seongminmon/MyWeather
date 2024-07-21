//
//  CityViewModel.swift
//  MyWeather
//
//  Created by 김성민 on 7/20/24.
//

import Foundation

final class CityViewModel: BaseViewModel {
    
    var cityList = [City]()
    
    // Input
    var inputViewDidLoad: Observable<Void?> = Observable(nil)
    var inputSearchBarDidChange = Observable("")
    
    // Output
    var outputList: Observable<[City]> = Observable([])
    
    override func transform() {
        inputViewDidLoad.bind { [weak self] value in
            guard let self, value != nil, let data = loadJson() else { return }
            do {
                cityList = try JSONDecoder().decode([City].self, from: data)
                outputList.value = cityList
            } catch {
                outputList.value = []
            }
        }
        
        inputSearchBarDidChange.bind { [weak self] value in
            guard let self else { return }
            search(value)
            print(value, outputList.value.count)
        }
    }
    
    private func loadJson() -> Data? {
        // 불러올 파일 이름
        let fileName: String = "CityList"
        // 불러올 파일의 확장자명
        let extensionType = "json"
        
        // 파일 위치
        guard let fileLocation = Bundle.main.url(forResource: fileName, withExtension: extensionType) else { return nil }
        
        do {
            // 해당 위치의 파일을 Data로 초기화하기
            let data = try Data(contentsOf: fileLocation)
            return data
        } catch {
            // 잘못된 위치나 불가능한 파일 처리
            print("로컬 JSON 로드 실패")
            return nil
        }
    }
    
    private func search(_ text: String) {
        // 공백제거, 소문자로 변환
        let text = text.trimmingCharacters(in: .whitespaces).lowercased()
        // 빈값이면
        if text == "" {
            outputList.value = cityList
        } else {
            // 대소문자 구별없이 비교
            outputList.value = cityList.filter { $0.name.lowercased().contains(text) }
        }
    }
}
