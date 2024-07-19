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

final class MainView: BaseView {
    let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
    }
    
    let contentView = UIView()
    
    let backgroundImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
    }
    
    let weatherView = UIView()
    
    let cityNameLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 30)
        $0.textAlignment = .center
    }
    
    let temparatureLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 80)
        $0.textAlignment = .center
    }
    
    let weatherDescriptionLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 24)
        $0.textAlignment = .center
    }
    
    let temparatureDescriptionLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 24)
        $0.textAlignment = .center
    }
    
    let hourContainerView = ContainerView().then {
        $0.configureLabel(imageName: "calendar", text: " 3시간 간격의 일기예보")
    }
    
    let collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: BaseViewController.collectionViewLayout()
    ).then {

        $0.register(WeatherCollectionViewCell.self, forCellWithReuseIdentifier: WeatherCollectionViewCell.description())
        $0.showsHorizontalScrollIndicator = false
        $0.backgroundColor = .clear
    }
    
    let dayContainerView = ContainerView().then {
        $0.configureLabel(imageName: "calendar", text: "  5일 간의 일기예보")
    }
    
    let tableView = UITableView().then {
        $0.register(WeatherTableViewCell.self, forCellReuseIdentifier: WeatherTableViewCell.description())
        $0.rowHeight = 60
        $0.isScrollEnabled = false
    }
    
    let mapContainerView = ContainerView().then {
        $0.configureLabel(imageName: "thermometer.medium", text: " 위치")
    }
    
    let mapView = MKMapView()
    
    let windSpeedContainerView = ContainerView().then {
        $0.configureLabel(imageName: "wind", text: " 바람 속도")
    }
    
    let windSpeedLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 24)
    }
    
    let cloudContainerView = ContainerView().then {
        $0.configureLabel(imageName: "drop.fill", text: " 구름")
    }
    
    let cloudLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 24)
    }
    
    let barometerContainerView = ContainerView().then {
        $0.configureLabel(imageName: "thermometer.medium", text: " 기압")
    }
    
    let barometerLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 24)
    }
    
    let humidityContainerView = ContainerView().then {
        $0.configureLabel(imageName: "humidity", text: " 습도")
    }
    
    let humidityLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 24)
    }
    
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
            $0.height.equalTo(30 + 200)
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
    
    override func configureView() {
        backgroundImageView.image = UIImage(named: "cloud")
    }
    
    func configureWeatherView(_ data: WeatherResponse?) {
        guard let data else { return }
        cityNameLabel.text = data.name
        temparatureLabel.text = " \(data.main.tempCelsius)°"
        weatherDescriptionLabel.text = data.weather.first!.description
        temparatureDescriptionLabel.text = "최고: \(data.main.tempMaxCelsius)° | 최저: \(data.main.tempMinCelsius)°"
        
        windSpeedLabel.text = "\(data.wind.speed)m/s"
        cloudLabel.text = "\(data.clouds.all)%"
        barometerLabel.text = "\(data.main.pressure)hpa"
        humidityLabel.text = "\(data.main.humidity)%"
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
    
    @objc func mapButtonTapped() {
        print(#function)
    }
    
    @objc func cityButtonTapped() {
        print(#function)
    }
}
