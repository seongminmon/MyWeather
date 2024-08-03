//
//  MainView.swift
//  MyWeather
//
//  Created by 김성민 on 7/19/24.
//

import UIKit
import MapKit
import SnapKit
import Then

protocol MainViewDelegate: AnyObject {
    func mapButtonTapped()
    func cityButtonTapped()
}

final class MainView: BaseView {
    
    private let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
    }
    
    private let contentView = UIView()
    
    private let backgroundImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
    }
    
    private let weatherView = UIView()
    
    private let cityNameLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 30)
        $0.textAlignment = .center
    }
    
    private let temparatureLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 80)
        $0.textAlignment = .center
    }
    
    private let weatherDescriptionLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 24)
        $0.textAlignment = .center
    }
    
    private let temparatureDescriptionLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 24)
        $0.textAlignment = .center
    }
    
    private let hourContainerView = ContainerView().then {
        $0.configureLabel(imageName: "calendar", text: " 3시간 간격의 일기예보")
    }
    
    private let collectionViewLayout = UICollectionViewFlowLayout().then {
        let sectionSpacing: CGFloat = 10
        let cellSpacing: CGFloat = 10
        let width: CGFloat = 50
        let height: CGFloat = 120
        
        $0.itemSize = CGSize(width: width, height: height)
        $0.scrollDirection = .horizontal
        $0.minimumInteritemSpacing = cellSpacing
        $0.minimumLineSpacing = cellSpacing
        $0.sectionInset = UIEdgeInsets(top: sectionSpacing, left: sectionSpacing, bottom: sectionSpacing, right: sectionSpacing)
    }
    
    lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: collectionViewLayout
    ).then {
        $0.register(WeatherCollectionViewCell.self, forCellWithReuseIdentifier: WeatherCollectionViewCell.description())
        $0.showsHorizontalScrollIndicator = false
        $0.backgroundColor = .clear
    }
    
    private let dayContainerView = ContainerView().then {
        $0.configureLabel(imageName: "calendar", text: " 5일 간의 일기예보")
    }
    
    let tableView = UITableView().then {
        $0.register(WeatherTableViewCell.self, forCellReuseIdentifier: WeatherTableViewCell.description())
        $0.rowHeight = 60
        $0.isScrollEnabled = false
        $0.backgroundColor = .clear
    }
    
    private let mapContainerView = ContainerView().then {
        $0.configureLabel(imageName: "thermometer.medium", text: " 위치")
    }
    
    private let mapView = MKMapView()
    
    private let windSpeedContainerView = ContainerView().then {
        $0.configureLabel(imageName: "wind", text: " 바람 속도")
    }
    
    private let windSpeedLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 24)
    }
    
    private let cloudContainerView = ContainerView().then {
        $0.configureLabel(imageName: "drop.fill", text: " 구름")
    }
    
    private let cloudLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 24)
    }
    
    private let barometerContainerView = ContainerView().then {
        $0.configureLabel(imageName: "thermometer.medium", text: " 기압")
    }
    
    private let barometerLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 24)
    }
    
    private let humidityContainerView = ContainerView().then {
        $0.configureLabel(imageName: "humidity", text: " 습도")
    }
    
    private let humidityLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 24)
    }
    
    var delegate: MainViewDelegate?
    
    override func addSubviews() {
        addSubview(backgroundImageView)
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(weatherView)
        contentView.addSubview(hourContainerView)
        contentView.addSubview(dayContainerView)
        contentView.addSubview(mapContainerView)
        contentView.addSubview(windSpeedContainerView)
        contentView.addSubview(cloudContainerView)
        contentView.addSubview(barometerContainerView)
        contentView.addSubview(humidityContainerView)
        
        weatherView.addSubview(cityNameLabel)
        weatherView.addSubview(temparatureLabel)
        weatherView.addSubview(weatherDescriptionLabel)
        weatherView.addSubview(temparatureDescriptionLabel)
        hourContainerView.addSubview(collectionView)
        dayContainerView.addSubview(tableView)
        mapContainerView.addSubview(mapView)
        windSpeedContainerView.addSubview(windSpeedLabel)
        cloudContainerView.addSubview(cloudLabel)
        barometerContainerView.addSubview(barometerLabel)
        humidityContainerView.addSubview(humidityLabel)
    }
    
    override func configureLayout() {
        backgroundImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.width.verticalEdges.equalToSuperview()
        }
        
        weatherView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(30)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(200)
        }
        
        cityNameLabel.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
        }
        
        temparatureLabel.snp.makeConstraints {
            $0.top.equalTo(cityNameLabel.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
        }
        
        weatherDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(temparatureLabel.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
        }
        
        temparatureDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(weatherDescriptionLabel.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
        }
        
        hourContainerView.snp.makeConstraints {
            $0.top.equalTo(weatherView.snp.bottom).offset(30)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(30 + 150)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(hourContainerView.separator.snp.bottom).offset(4)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        dayContainerView.snp.makeConstraints {
            $0.top.equalTo(hourContainerView.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(43 + 300)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(dayContainerView.separator.snp.bottom).offset(4)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        mapContainerView.snp.makeConstraints {
            $0.top.equalTo(dayContainerView.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(30 + 200)
        }
        
        mapView.snp.makeConstraints {
            $0.top.equalTo(mapContainerView.separator.snp.bottom).offset(4)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        windSpeedContainerView.snp.makeConstraints {
            $0.top.equalTo(mapContainerView.snp.bottom).offset(16)
            $0.leading.equalToSuperview().inset(16)
            $0.width.equalToSuperview().multipliedBy(0.43)
            $0.height.equalTo(windSpeedContainerView.snp.width)
        }
        
        windSpeedLabel.snp.makeConstraints {
            $0.top.equalTo(windSpeedContainerView.separator.snp.bottom).offset(4)
            $0.horizontalEdges.equalToSuperview().inset(8)
        }
        
        cloudContainerView.snp.makeConstraints {
            $0.top.equalTo(mapContainerView.snp.bottom).offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.size.equalTo(windSpeedContainerView)
        }
        
        cloudLabel.snp.makeConstraints {
            $0.top.equalTo(cloudContainerView.separator.snp.bottom).offset(4)
            $0.horizontalEdges.equalToSuperview().inset(8)
        }
        
        barometerContainerView.snp.makeConstraints {
            $0.top.equalTo(windSpeedContainerView.snp.bottom).offset(16)
            $0.leading.equalToSuperview().inset(16)
            $0.size.equalTo(windSpeedContainerView)
        }
        
        barometerLabel.snp.makeConstraints {
            $0.top.equalTo(barometerContainerView.separator.snp.bottom).offset(4)
            $0.horizontalEdges.equalToSuperview().inset(8)
        }
        
        humidityContainerView.snp.makeConstraints {
            $0.top.equalTo(windSpeedContainerView.snp.bottom).offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.size.equalTo(windSpeedContainerView)
            $0.bottom.equalToSuperview().inset(20)
        }
        
        humidityLabel.snp.makeConstraints {
            $0.top.equalTo(humidityContainerView.separator.snp.bottom).offset(4)
            $0.horizontalEdges.equalToSuperview().inset(8)
        }
    }
    
    override func configureNavigationBar(_ vc: UIViewController) {
        // 툴바 설정
        let mapButton = UIBarButtonItem(image: UIImage(systemName: "map"), style: .plain, target: self, action: #selector(mapButtonTapped))
        let cityButton = UIBarButtonItem(image: UIImage(systemName: "list.bullet"), style: .plain, target: self, action: #selector(cityButtonTapped))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)

        vc.navigationController?.isToolbarHidden = false
        vc.navigationController?.toolbar.tintColor = .white
        vc.toolbarItems = [mapButton, flexibleSpace, cityButton]
        
        // 네비게이션바 투명하게 만들기
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        vc.navigationController?.navigationBar.standardAppearance = appearance
        vc.navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        // 툴바 스크롤엣지에서도 투명하지 않게 만들기
        let toolbarAppearance = UIToolbarAppearance()
        toolbarAppearance.configureWithDefaultBackground()
        vc.navigationController?.toolbar.standardAppearance = toolbarAppearance
        vc.navigationController?.toolbar.scrollEdgeAppearance = toolbarAppearance
    }
    
    func configureWeatherView(_ data: WeatherOutput?) {
        guard let data else { return }
        cityNameLabel.text = data.cityName
        temparatureLabel.text = data.temp
        weatherDescriptionLabel.text = data.description.rawValue
        temparatureDescriptionLabel.text = data.tempDescription
        backgroundImageView.image = UIImage(named: data.description.imageName)
        
        // center를 중심으로 이동
        let center = CLLocationCoordinate2D(latitude: data.coord.lat, longitude: data.coord.lon)
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 500, longitudinalMeters: 500)
        mapView.setRegion(region, animated: true)
        
        // 기존 annotation 삭제
        mapView.removeAnnotations(mapView.annotations)
        
        // 맵뷰에 annotaion 추가
        let annotation = MKPointAnnotation()
        annotation.coordinate = center
        mapView.addAnnotation(annotation)
        
        windSpeedLabel.text = data.wind
        cloudLabel.text = data.cloud
        barometerLabel.text = data.barometer
        humidityLabel.text = data.humidity
    }
    
    @objc func mapButtonTapped() {
        delegate?.mapButtonTapped()
    }
    
    @objc func cityButtonTapped() {
        delegate?.cityButtonTapped()
    }
}
