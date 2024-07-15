//
//  MainViewController.swift
//  MyWeather
//
//  Created by 김성민 on 7/12/24.
//

import UIKit
import SnapKit
import Then

final class MainViewController: BaseViewController {

    let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
    }
    
    let contentView = UIView()
    
    let hourContainerView = ContainerView()
    
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
    
    lazy var tableView = UITableView().then {
        $0.delegate = self
        $0.dataSource = self
        $0.register(WeatherTableViewCell.self, forCellReuseIdentifier: WeatherTableViewCell.identifier)
        $0.rowHeight = 60
        $0.isScrollEnabled = false
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
        
    }
    
    @objc func cityButtonTapped() {
        
    }
    
    override func addSubviews() {
        hourContainerView.addSubview(collectionView)
        contentView.addSubview(hourContainerView)
        contentView.addSubview(tableView)
        scrollView.addSubview(contentView)
        view.addSubview(scrollView)
    }
    
    override func configureLayout() {
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints {
            $0.width.verticalEdges.equalToSuperview()
        }
        
        hourContainerView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(30)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(230)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(hourContainerView.separator.snp.bottom).offset(4)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(collectionView.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(60 * 50)
            $0.bottom.equalToSuperview().inset(20)
        }
    }
    
    override func configureView() {
        hourContainerView.configureLabel(imageName: "calendar", text: " 3시간 간격의 일기예보")
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
        return 500
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: WeatherTableViewCell.identifier,
            for: indexPath
        ) as? WeatherTableViewCell else {
            return UITableViewCell()
        }
        cell.backgroundColor = .systemPink
        return cell
    }
}
