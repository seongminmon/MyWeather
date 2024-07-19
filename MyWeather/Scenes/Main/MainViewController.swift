//
//  MainViewController.swift
//  MyWeather
//
//  Created by 김성민 on 7/12/24.
//

import UIKit
import MapKit

final class MainViewController: BaseViewController<MainView, MainViewModel> {

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.inputViewDidLoadTrigger.value = ()
    }
    
    override func configureView() {
        baseView.configureNavigationBar(self)
        baseView.collectionView.delegate = self
        baseView.collectionView.dataSource = self
        baseView.tableView.delegate = self
        baseView.tableView.dataSource = self
    }
    
    override func bindData() {
        viewModel.outputWeatherResponse.bind { [weak self] _ in
            guard let self else { return }
            baseView.configureWeatherView(viewModel.outputWeatherResponse.value)
        }
        
        viewModel.outputForecastResponse.bind { [weak self] _ in
            guard let self else { return }
            baseView.collectionView.reloadData()
            baseView.tableView.reloadData()
        }
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.outputForecastResponse.value?.list.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: WeatherCollectionViewCell.description(),
            for: indexPath
        ) as? WeatherCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let data = viewModel.outputForecastResponse.value?.list[indexPath.item]
        cell.configureCell(data: data)
        return cell
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: WeatherTableViewCell.description(),
            for: indexPath
        ) as? WeatherTableViewCell else {
            return UITableViewCell()
        }
        cell.backgroundColor = .purple
        return cell
    }
}
