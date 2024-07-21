//
//  CityViewController.swift
//  MyWeather
//
//  Created by 김성민 on 7/20/24.
//

import UIKit

final class CityViewController: BaseViewController<CityView, CityViewModel> {
    
    // 역값 전달을 위한 클로저
    var sendCityID: ((String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.inputViewDidLoad.value = ()
    }
    
    override func configureView() {
        baseView.configureNavigationBar(self)
        baseView.searchBar.delegate = self
        baseView.collectionView.delegate = self
    }
    
    override func bindData() {
        viewModel.outputList.bind { [weak self] list in
            guard let self else { return }
            baseView.updateSnapshot(list)
        }
        
        viewModel.outputCityID.bind { [weak self] cityID in
            guard let self else { return }
            sendCityID?(cityID)
            navigationController?.popViewController(animated: true)
        }
    }
}

extension CityViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.inputSearchBarDidChange.value = searchText
    }
}

extension CityViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.inputDidSelectItemAt.value = indexPath.item
    }
}
