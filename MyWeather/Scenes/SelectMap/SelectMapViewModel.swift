//
//  SelectMapViewModel.swift
//  MyWeather
//
//  Created by 김성민 on 7/21/24.
//

import Foundation
import MapKit

final class SelectMapViewModel: BaseViewModel {
    
    // Input
    var inputViewDidLoad = Observable<Void?>(nil)
    var inputMapViewTapped = Observable<CLLocationCoordinate2D?>(nil)
    
    // Output
    // 이전 화면에서 전달
    var outputStartCoord = Observable<CLLocationCoordinate2D?>(nil)
    var outputAlert = Observable<CLLocationCoordinate2D?>(nil)
    
    override func transform() {
        inputViewDidLoad.bind { [weak self] _ in
            guard let self else { return }
            outputStartCoord.value = outputStartCoord.value
        }
        
        inputMapViewTapped.bind { [weak self] value in
            guard let self else { return }
            outputAlert.value = value
        }
    }
}
