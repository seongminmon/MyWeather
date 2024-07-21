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
    
    enum Section: CaseIterable {
        case main
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Section, City>!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureDataSource()
        updateSnapshot([])
    }
    
    override func configureNavigationBar(_ vc: UIViewController) {
        vc.navigationItem.title = "도시 검색"
    }
    
    override func addSubviews() {
        addSubview(collectionView)
    }
    
    override func configureLayout() {
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        collectionView.backgroundColor = .red
    }
    
    private func configureDataSource() {
        let registration = UICollectionView.CellRegistration<UICollectionViewListCell, City> { cell, indexPath, itemIdentifier in
            // systemCell
            var content = UIListContentConfiguration.valueCell()
            content.text = itemIdentifier.name
            content.secondaryText = itemIdentifier.country
            content.secondaryTextProperties.color = .gray
            cell.contentConfiguration = content
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(
                using: registration,
                for: indexPath,
                item: itemIdentifier
            )
            return cell
        }
    }
    
    func updateSnapshot(_ items: [City]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, City>()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(items, toSection: .main)
        dataSource.apply(snapshot)
    }
}
