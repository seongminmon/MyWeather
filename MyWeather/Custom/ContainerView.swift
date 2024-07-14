//
//  ContainerView.swift
//  MyWeather
//
//  Created by 김성민 on 7/13/24.
//

import UIKit
import SnapKit
import Then

final class ContainerView: BaseView {
    
    let headerLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 15)
        $0.textColor = .white
    }
    
    let separator = UIView()
    
    override func addSubviews() {
        addSubview(headerLabel)
        addSubview(separator)
    }
    
    override func configureLayout() {
        headerLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(30)
        }
        
        separator.snp.makeConstraints {
            $0.top.equalTo(headerLabel.snp.bottom)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(1)
        }
    }
    
    override func configureView() {
        layer.opacity = 0.8
        clipsToBounds = true
        layer.cornerRadius = 10
        separator.backgroundColor = .white
    }
    
}
