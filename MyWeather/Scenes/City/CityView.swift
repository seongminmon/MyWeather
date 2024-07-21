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
    
    let searchBar = UISearchBar().then {
        $0.placeholder = "도시 이름을 검색해보세요"
    }
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout()).then {
        $0.keyboardDismissMode = .onDrag
    }
    
    enum Section: CaseIterable {
        case main
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Section, City>!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureDataSource()
    }
    
    override func configureNavigationBar(_ vc: UIViewController) {
        vc.navigationItem.title = "도시 검색"
    }
    
    override func addSubviews() {
        addSubview(searchBar)
        addSubview(collectionView)
    }
    
    override func configureLayout() {
        searchBar.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(safeAreaLayoutGuide)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom)
            $0.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let config = UICollectionLayoutListConfiguration(appearance: .plain)
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        return layout
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
