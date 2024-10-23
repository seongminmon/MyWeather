//
//  SelectMapViewController.swift
//  MyWeather
//
//  Created by 김성민 on 7/21/24.
//

import UIKit
import MapKit

final class SelectMapViewController: BaseViewController<SelectMapView, SelectMapViewModel> {
    
    var sendCoordinate: ((CLLocationCoordinate2D) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        baseView.configureNavigationBar(self)
        viewModel.inputViewDidLoad.value = ()
    }
    
    override func configureView() {
        baseView.delegate = self
    }
    
    override func bindData() {
        // MapView의 시작 위치 설정 (없다면 서울)
        viewModel.outputStartCoord.bind { [weak self] value in
            guard let self else { return }
            baseView.configureMapView(value ?? CLLocationCoordinate2D(latitude: Seoul.coord.lat, longitude: Seoul.coord.lon))
        }
        
        viewModel.outputAlert.bind { [weak self] value in
            guard let self, let value else { return }
            presentAlert("이 위치로 검색하시겠습니까?") { _ in
                self.sendCoordinate?(value)
                self.navigationController?.popViewController(animated: true)
            }
        }
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
        viewModel.inputMapViewTapped.value = coord
    }
}
