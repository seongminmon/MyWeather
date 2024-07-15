//
//  MainViewController.swift
//  MyWeather
//
//  Created by 김성민 on 7/12/24.
//

import UIKit
import MapKit
import SnapKit
import Then

final class MainViewController: BaseViewController {

    let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
    }
    
    let contentView = UIView()
    
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
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout()).then {
        $0.delegate = self
        $0.dataSource = self
        $0.register(WeatherCollectionViewCell.self, forCellWithReuseIdentifier: WeatherCollectionViewCell.identifier)
        $0.showsHorizontalScrollIndicator = false
        $0.backgroundColor = .clear
    }
    
    func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        
        let sectionSpacing: CGFloat = 10
        let cellSpacing: CGFloat = 10
        
        // 셀 사이즈
        let width: CGFloat = 50
        let height: CGFloat = width * 3
        layout.itemSize = CGSize(width: width, height: height)
        // 스크롤 방향
        layout.scrollDirection = .horizontal
        // 셀 사이 거리 (가로)
        layout.minimumInteritemSpacing = cellSpacing
        // 셀 사이 거리 (세로)
        layout.minimumLineSpacing = cellSpacing
        // 섹션 인셋
        layout.sectionInset = UIEdgeInsets(top: sectionSpacing, left: sectionSpacing, bottom: sectionSpacing, right: sectionSpacing)
        
        return layout
    }
    
    let dayContainerView = ContainerView().then {
        $0.configureLabel(imageName: "calendar", text: "  5일 간의 일기예보")
    }
    
    lazy var tableView = UITableView().then {
        $0.delegate = self
        $0.dataSource = self
        $0.register(WeatherTableViewCell.self, forCellReuseIdentifier: WeatherTableViewCell.identifier)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureNavigationBar() {
        // 툴바 설정
        let mapButton = UIBarButtonItem(image: UIImage(systemName: "map"), style: .plain, target: self, action: #selector(mapButtonTapped))
        let cityButton = UIBarButtonItem(image: UIImage(systemName: "list.bullet"), style: .plain, target: self, action: #selector(cityButtonTapped))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)

        navigationController?.isToolbarHidden = false
        navigationController?.toolbar.tintColor = .white
        toolbarItems = [mapButton, flexibleSpace, cityButton]
    }
    
    @objc func mapButtonTapped() {
        print(#function)
    }
    
    @objc func cityButtonTapped() {
        print(#function)
    }
    
    override func addSubviews() {
        view.addSubview(scrollView)
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
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
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
            $0.height.equalTo(30 + 300)
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
            $0.width.equalTo(view.frame.width / 2 - 20)
            $0.height.equalTo(windSpeedContainerView.snp.width)
        }
        
        windSpeedLabel.snp.makeConstraints {
            $0.top.equalTo(windSpeedContainerView.separator.snp.bottom)
            $0.horizontalEdges.equalToSuperview().inset(8)
        }
        
        cloudContainerView.snp.makeConstraints {
            $0.top.equalTo(mapContainerView.snp.bottom).offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.size.equalTo(windSpeedContainerView)
        }
        
        cloudLabel.snp.makeConstraints {
            $0.top.equalTo(cloudContainerView.separator.snp.bottom)
            $0.horizontalEdges.equalToSuperview().inset(8)
        }
        
        barometerContainerView.snp.makeConstraints {
            $0.top.equalTo(windSpeedContainerView.snp.bottom).offset(16)
            $0.leading.equalToSuperview().inset(16)
            $0.size.equalTo(windSpeedContainerView)
        }
        
        barometerLabel.snp.makeConstraints {
            $0.top.equalTo(barometerContainerView.separator.snp.bottom)
            $0.horizontalEdges.equalToSuperview().inset(8)
        }
        
        humidityContainerView.snp.makeConstraints {
            $0.top.equalTo(windSpeedContainerView.snp.bottom).offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.size.equalTo(windSpeedContainerView)
            // TODO: - 아래에 컨텐츠 더 추가되면 이동
            $0.bottom.equalToSuperview().inset(20)
        }
        
        humidityLabel.snp.makeConstraints {
            $0.top.equalTo(humidityContainerView.separator.snp.bottom)
            $0.horizontalEdges.equalToSuperview().inset(8)
        }
    }
    
    override func configureView() {
        cityNameLabel.text = "Jeju City"
        temparatureLabel.text = " 5.9°"
        weatherDescriptionLabel.text = "Broken Clouds"
        temparatureDescriptionLabel.text = "최고: 7.0° | 최저: -4.2°"
        
        windSpeedLabel.text = "1.35m/s"
        cloudLabel.text = "50%"
        barometerLabel.text = "1,020hpa"
        humidityLabel.text = "73%"
    }
    
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: WeatherCollectionViewCell.identifier,
            for: indexPath
        ) as? WeatherCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.backgroundColor = .orange
        return cell
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: WeatherTableViewCell.identifier,
            for: indexPath
        ) as? WeatherTableViewCell else {
            return UITableViewCell()
        }
        cell.backgroundColor = .purple
        return cell
    }
}
