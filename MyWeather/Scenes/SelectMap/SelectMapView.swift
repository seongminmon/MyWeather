//
//  SelectMapView.swift
//  MyWeather
//
//  Created by 김성민 on 7/21/24.
//

import UIKit
import MapKit
import SnapKit
import Then

protocol SelectMapViewDelegate: AnyObject {
    func mapViewTapped(coord: CLLocationCoordinate2D)
}

final class SelectMapView: BaseView {
    
    let mapView = MKMapView()
    
    var delegate: SelectMapViewDelegate?
    
    override func addSubviews() {
        addSubview(mapView)
    }
    
    override func configureLayout() {
        mapView.snp.makeConstraints {
            $0.edges.equalTo(safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(mapViewTapped)
        )
        mapView.addGestureRecognizer(tapGesture)
    }
    
    func configureMapView(_ center: CLLocationCoordinate2D) {
        // center를 중심으로 이동
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 500, longitudinalMeters: 500)
        mapView.setRegion(region, animated: true)
        setAnnotation(center)
    }
    
    @objc func mapViewTapped(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: mapView)
        let coordinate = mapView.convert(location, toCoordinateFrom: mapView)
        setAnnotation(coordinate)
        // vc에 값 전달
        delegate?.mapViewTapped(coord: coordinate)
    }
    
    private func setAnnotation(_ coordinate: CLLocationCoordinate2D) {
        // 기존 annotaion 삭제
        mapView.removeAnnotations(mapView.annotations)
        // 맵뷰에 annotaion 추가
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
    }
}
