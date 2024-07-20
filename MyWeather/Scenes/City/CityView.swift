//
//  CityView.swift
//  MyWeather
//
//  Created by 김성민 on 7/20/24.
//

import UIKit
import SnapKit
import Then

final class CityView: BaseView {
    

    private func createLayout() -> UICollectionViewLayout {
        let config = UICollectionLayoutListConfiguration(appearance: .plain)
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        return layout
    }
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    
    override func configureNavigationBar(_ vc: UIViewController) {
        
    }
    
    override func addSubviews() {
        
    }
    
    override func configureLayout() {
        
    }
    
    override func configureView() {
        
    }
    
}
