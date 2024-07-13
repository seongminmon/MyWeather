//
//  MainViewController.swift
//  MyWeather
//
//  Created by 김성민 on 7/12/24.
//

import UIKit
import SnapKit
import Then

final class MainViewController: UIViewController {

    let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
    }
    
    let contentView = UIView()
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout()).then {
        $0.delegate = self
        $0.dataSource = self
        $0.register(WeatherCollectionViewCell.self, forCellWithReuseIdentifier: WeatherCollectionViewCell.id)
        $0.showsHorizontalScrollIndicator = false
    }
    
    func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        
        let sectionSpacing: CGFloat = 10
        let cellSpacing: CGFloat = 10
        let cellCount: CGFloat = 1
        
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
        $0.rowHeight = 60
        $0.register(WeatherTableViewCell.self, forCellReuseIdentifier: WeatherTableViewCell.id)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        addSubviews()
        configureLayout()
        configureView()
    }
    
    func configureNavigationBar() {
        
    }
    
    func addSubviews() {
        contentView.addSubview(collectionView)
        contentView.addSubview(tableView)
        scrollView.addSubview(contentView)
        view.addSubview(scrollView)
    }
    
    func configureLayout() {
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints {
            $0.width.verticalEdges.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(200)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(collectionView.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(60 * 5)
            $0.bottom.equalToSuperview().inset(20)
        }
    }
    
    func configureView() {
        
    }
    
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: WeatherCollectionViewCell.id,
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
            withIdentifier: WeatherTableViewCell.id,
            for: indexPath
        ) as? WeatherTableViewCell else {
            return UITableViewCell()
        }
        cell.backgroundColor = .blue
        return cell
    }
}
