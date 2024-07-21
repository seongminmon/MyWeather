//
//  CityViewController.swift
//  MyWeather
//
//  Created by 김성민 on 7/20/24.
//

import UIKit

final class CityViewController: BaseViewController<CityView, CityViewModel> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.inputViewDidLoad.value = ()
    }
    
    override func configureView() {
        baseView.configureNavigationBar(self)
        baseView.searchBar.delegate = self
    }
    
    override func bindData() {
        viewModel.outputList.bind { [weak self] list in
            guard let self else { return }
            baseView.updateSnapshot(list)
        }
    }
}

extension CityViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.inputSearchBarDidChange.value = searchText
    }
}
