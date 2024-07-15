//
//  BaseViewController.swift
//  MyWeather
//
//  Created by 김성민 on 7/13/24.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.backButtonDisplayMode = .minimal
        configureNavigationBar()
        addSubviews()
        configureLayout()
        configureView()
    }
    
    func configureNavigationBar() {}
    func addSubviews() {}
    func configureLayout() {}
    func configureView() {}
    
    static func collectionViewLayout() -> UICollectionViewLayout {
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
}
