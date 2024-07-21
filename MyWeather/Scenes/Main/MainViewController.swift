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
        baseView.delegate = self
        viewModel.inputCityIDNetworkTrigger.value = ""
    }
    
    override func configureView() {
        baseView.configureNavigationBar(self)
        baseView.collectionView.delegate = self
        baseView.collectionView.dataSource = self
        baseView.tableView.delegate = self
        baseView.tableView.dataSource = self
    }
    
    override func bindData() {
        viewModel.outputWeather.bind { [weak self] value in
            guard let self, let value else { return }
            baseView.configureWeatherView(value)
        }
        
        viewModel.outputForeCastHourList.bind { [weak self] _ in
            guard let self else { return }
            baseView.collectionView.reloadData()
        }
        
        viewModel.outputForeCastDayList.bind { [weak self] _ in
            guard let self else { return }
            baseView.tableView.reloadData()
        }
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.outputForeCastHourList.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: WeatherCollectionViewCell.description(),
            for: indexPath
        ) as? WeatherCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let data = viewModel.outputForeCastHourList.value[indexPath.item]
        cell.configureCell(data: data)
        return cell
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.outputForeCastDayList.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: WeatherTableViewCell.description(),
            for: indexPath
        ) as? WeatherTableViewCell else {
            return UITableViewCell()
        }
        
        let data = viewModel.outputForeCastDayList.value[indexPath.row]
        cell.configureCell(data: data)
        cell.selectionStyle = .none
        return cell
    }
}

extension MainViewController: MainViewDelegate {
    func mapButtonTapped() {
        let vc = SelectMapViewController(view: SelectMapView(), viewModel: SelectMapViewModel())
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func cityButtonTapped() {
        let vc = CityViewController(view: CityView(), viewModel: CityViewModel())
        vc.sendCityID = { [weak self] cityID in
            guard let self else { return }
            viewModel.inputCityIDNetworkTrigger.value = cityID
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}
