//
//  SelectMapViewController.swift
//  MyWeather
//
//  Created by 김성민 on 7/21/24.
//

import UIKit
import MapKit

final class SelectMapViewController: BaseViewController<SelectMapView, SelectMapViewModel> {
    
    // 이전 화면에서 전달
    var startCoord: CLLocationCoordinate2D?
    
    // 역값 전달
    var sendCoordinate: ((CLLocationCoordinate2D) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureView() {
        // MapView의 시작 위치 설정 (없다면 서울)
        baseView.configureMapView(startCoord ?? CLLocationCoordinate2D(latitude: 127.0, longitude: 37.583328))
        baseView.delegate = self
    }
    
    override func bindData() {
        //
    }
    
    func presentAlert(
        _ title: String?,
        completionHandler: @escaping (UIAlertAction) -> Void
    ) {
        let alert = UIAlertController(
            title: title,
            message: nil,
            preferredStyle: .actionSheet
        )
        let confirm = UIAlertAction(title: "확인", style: .default, handler: completionHandler)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        alert.addAction(confirm)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
}

extension SelectMapViewController: SelectMapViewDelegate {
    func mapViewTapped(coord: CLLocationCoordinate2D) {
        presentAlert("이 위치로 검색하시겠습니까?") { [weak self] _ in
            guard let self else { return }
            sendCoordinate?(coord)
            navigationController?.popViewController(animated: true)
        }
    }
}
